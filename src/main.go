package main

import (
	"io"
	"fmt"
	"log"
	"net/http"
)

func main() {
	fmt.Println("Booting server...")

	http.HandleFunc("/", func (w http.ResponseWriter, r *http.Request) {
		fmt.Println("Handling request to /")
		_, err := io.WriteString(w, "Eu sou FullCycle")
		if err != nil {
			log.Fatal(err)
		}
	})

	http.HandleFunc("/healthcheck", func (w http.ResponseWriter, r *http.Request) {
		fmt.Println("Handling request to /healthcheck")
		w.WriteHeader(200)
	})
	
	log.Fatal(http.ListenAndServe(":8080", nil))
}
