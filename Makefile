BINARY := nordvpn-tui
PKG    := ./...

.PHONY: build run run-fake test lint fmt tidy clean

build:
	go build -o bin/$(BINARY) ./cmd/nordvpn-tui

run: build
	./bin/$(BINARY)

run-fake: build
	./bin/$(BINARY) --fake

test:
	go test $(PKG)

lint:
	golangci-lint run

fmt:
	gofmt -w .

tidy:
	go mod tidy

clean:
	rm -rf bin
