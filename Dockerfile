# Use the official Golang image as the base image for the build stage
FROM golang:1.23.0-alpine AS build

# Set the working directory to /app
WORKDIR /app

# Copy the current directory contents into the container at /app
COPY . /app

# Build the livepeer-exporter binary
RUN go build -o livepeer-exporter

# Use a smaller base image for the final stage
FROM alpine:3.19

# Copy the livepeer-exporter binary from the build stage
COPY --from=build /app/livepeer-exporter /usr/local/bin/

# Expose port 9153 for the livepeer-exporter to publish metrics
EXPOSE 9153

# Run the livepeer-exporter binary when the container starts
CMD ["livepeer-exporter"]
