# Start from golang base image
FROM golang:alpine AS build-stage

LABEL maintainer="Andrew Alizaga"


WORKDIR /app

COPY go.mod go.sum ./
RUN go mod download

COPY *.go ./

#BUILD
RUN CGO_ENABLED=0 GOOS=linux go build -o /build

#RUN TESTS ON CONTAINER 
FROM build-stage AS run-test-stage
RUN go test -v ./...


#LEAN IMAGE
FROM gcr.io/distroless/base-debian11 AS build-release-stage

WORKDIR / 

COPY --from=build-stage /build /build

EXPOSE 8080

USER nonroot:nonroot

CMD [ "/build" ]