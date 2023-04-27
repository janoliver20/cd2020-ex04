FROM golang:1.20-alpine

# Set maintainer label: maintainer=[YOUR-EMAIL]
LABEL maintainer="jan.cortiel@icloud.com"

# Set working directory: `/src`
WORKDIR /src

# Copy local file `main.go` to the working directory
COPY go.mod ./

RUN go mod download

COPY *.go ./

# List items in the working directory (ls)
RUN ls

# testing
RUN go test -v ./...

# Build the GO app as myapp binary and move it to /usr/
RUN CGO_ENABLED=0 GOOS=linux go build -a -installsuffix cgo -o time-server .
RUN mv time-server /usr/

#Expose port 8888
EXPOSE 8888

# Run the service myapp when a container of this image is launched
CMD ["/usr/time-server"]