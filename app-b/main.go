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
	//mux.HandleFunc("/goroutines", goroutinesHandler)

	log.Println("Starting server at: 8081 ...")
	log.Fatal(http.ListenAndServe(":8081", mux))
}

func infoHandler(w http.ResponseWriter, r *http.Request) {
	fmt.Fprintf(w, "hostname:%s\nversion:%s\n", host, version)
}

func inspectHandler(w http.ResponseWriter, r *http.Request) {
	testVolumeFiles, err := listDirectory("/test-volume")
	fmt.Fprintf(w, "> ls /test-volume\n%v\nerr: %v\n\n", testVolumeFiles, err)
}

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
