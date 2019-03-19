package main

import (
	"fmt"
	"io/ioutil"
	"log"
	"net/http"
	"os"
)

var (
	host    = os.Getenv("HOSTNAME")
	version = os.Getenv("VERSION")
)

func main() {
	mux := http.NewServeMux()
	mux.HandleFunc("/", infoHandler)
	mux.HandleFunc("/list", inspectHandler)

	log.Println("Starting server at: 8081 ...")

	err := http.ListenAndServe(":8081", mux)
	if err != nil {
		log.Fatal(err)
	}
}

// informations about hostname & version
func infoHandler(w http.ResponseWriter, r *http.Request) {
	fmt.Fprintf(w, "hostname:%s\nversion:%s\n", host, version)
}

// ls -la /test-volume content
func inspectHandler(w http.ResponseWriter, r *http.Request) {
	testVolumeFiles, err := listDirectory("/test-volume")
	fmt.Fprintf(w, "> ls /test-volume\n%v\nerr: %v\n\n", testVolumeFiles, err)
}

// Return all files & directories within a directory
func listDirectory(path string) ([]string, error) {
	files, err := ioutil.ReadDir(path)
	if err != nil {
		return nil, err
	}

	fileNames := []string{}

	for _, f := range files {
		fileNames = append(fileNames, f.Name())
	}

	return fileNames, nil
}
