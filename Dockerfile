FROM golang:1.23 AS builder

WORKDIR /app

COPY go.mod .
COPY main.go .
COPY templates ./templates

RUN CGO_ENABLED=0 go build -o bandnames .

FROM scratch

COPY --from=builder /app/bandnames /bandnames
COPY --from=builder /app/templates ./templates

CMD ["/bandnames"]
