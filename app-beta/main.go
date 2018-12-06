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

	// New mux server
	mux := http.NewServeMux()

	// Set / handler
	mux.HandleFunc("/", infoHandler)

	// Set /list handler
	// This will try to execute ls -la on /test-volume directory
	mux.HandleFunc("/list", inspectHandler)

	// Log server starting
	log.Println("Starting server at: 8081 ...")

	// Listen and serve
	err := http.ListenAndServe(":8081", mux)
	if err != nil {
		// If error exit 1
		log.Fatal(err)
	}
}

// Return informations about hostname & version
func infoHandler(w http.ResponseWriter, r *http.Request) {
	fmt.Fprintf(w, "hostname:%s\nversion:%s\n", host, version)
}

// Return infromations about /test-volume content
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

/*
//mux.HandleFunc("/goroutines", goroutinesHandler)

// multi threading example
func goroutinesHandler(w http.ResponseWriter, r *http.Request) {

	done := make(chan string)
	go func(rw http.ResponseWriter) {
		rootFiles, err := listDirectory("/var")
		s := fmt.Sprintf("> ls /var\n%v\nerr: %v\n\n", rootFiles, err)
		done <- s
	}(w)

	go func(rw http.ResponseWriter) {
		testVolumeFiles, err := listDirectory("/usr")
		s := fmt.Sprintf("> ls /usr\n%v\nerr: %v\n\n", testVolumeFiles, err)
		//time.Sleep(200 * time.Millisecond)
		done <- s
	}(w)

	var result1 = <-done
	fmt.Fprintf(w, result1)
	fmt.Fprintf(w, <-done)

}

*/
