FROM golang:1.11

# Add server file
ADD main.go .

# Compile server
RUN go build -o server.o

# Define environ
ENV VERSION 1

# Expose port 8081 in container
EXPOSE 8081

# Execute server binary
ENTRYPOINT [ "./server.o" ]