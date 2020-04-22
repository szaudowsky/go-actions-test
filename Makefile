GOLANG_VERSION := 1.14.2
ALPINE_VERSION := 3.11

GIT_REPO := github.com/szaudowsky/go-actions-test
APP_NAME := go-actions-test

VERSION ?= $(shell git describe --always)
BUILD_TIME ?= $(shell date -u '%Y-%m-%d %H:%M:%S')

GOFILES := $(shell find . -name "*.go" -type f -not -path "./vendor/*")
PACKAGES ?= $(shell go list ./ ... | grep -v /vendor/)

vet: ## Runs `go vet`
	go vet $(PACKAGES)

fmt: ## Formats all Go files
	gofmt -l -s -w $(GOFILES)

deps: ## Sync dependencies
	go mod tidy

build: ## Builds app locally
	CGO_ENABLED=0 \
	go build \
	-v \
	-o $(APP_NAME)-$(VERSION) .

run: ## Run app on local env
	go run .

test: ## Run all unit tests and generate coverage report
	go test -coverprofile coverage.out -v ./...
	go tool cover -html=coverage.out -o coverage_report.html

race: ## Run all unit tests with -race flag
	go test -race -coverprofile=coverage.out -covermode=atomic
	go tool cover -html=coverage.out -o coverage_report.html
	