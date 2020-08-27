FROM golang:1.14-alpine AS build

RUN apk add --no-cache curl

WORKDIR /usr/local/src/app
COPY src/ ./
RUN go build -o /usr/local/bin/app.exe

EXPOSE 8080
CMD ["go", "run", "main.go"]
HEALTHCHECK --interval=10s --timeout=5s --start-period=5s --retries=3 \
            CMD [ "curl", "-fsL", "http://localhost:8080/healthcheck" ]

FROM alpine:3.12

RUN apk add --no-cache curl

WORKDIR /app
RUN useradd app && chown -R app:app /app
COPY --from=build /usr/local/bin/app.exe ./app.exe

EXPOSE 8080
CMD ["./app.exe"]

HEALTHCHECK --interval=10s --timeout=5s --start-period=5s --retries=3 \
            CMD [ "curl", "-fsL", "http://localhost:8080/healthcheck" ]
