FROM golang:1.11

ADD main.go .

RUN go build -o server.o

ENV VERSION 1

ENTRYPOINT [ "./server.o" ]