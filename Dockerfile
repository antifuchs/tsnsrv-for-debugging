FROM golang:1.20 as builder

WORKDIR /work
ENV CGO_ENABLED=0

COPY go.mod go.sum ./
RUN go mod download && go mod verify

COPY . .

RUN go build -ldflags="-s -w" -v

FROM scratch
COPY --from=builder /work/tsnsrv /usr/bin/tsnsrv

CMD ["/usr/bin/tsnsrv"]