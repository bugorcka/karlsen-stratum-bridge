# Many thanks to original author Brandon Smith (onemorebsmith).
FROM golang:1.19.1 as builder

LABEL org.opencontainers.image.description="Dockerized Nautilus Stratum Bridge"
LABEL org.opencontainers.image.authors="Nautilus Community"
LABEL org.opencontainers.image.source="https://github.com/bugorcka/nautilusstratum
WORKDIR /go/src/app
ADD go.mod .
ADD go.sum .
RUN go mod download

ADD . .
RUN go build -o /go/bin/app ./cmd/karlsenbridge


FROM gcr.io/distroless/base:nonroot
COPY --from=builder /go/bin/app /
COPY cmd/karlsenbridge/config.yaml /

WORKDIR /
ENTRYPOINT ["/app"]
