PLATFORM = linux/386
TAG = pl1

all: build run
.PHONY: all

run:
	docker run --rm -it --privileged --platform "${PLATFORM}" "${TAG}"
.PHONY: run

build:
	docker build --platform "${PLATFORM}" --tag "${TAG}" .
.PHONY: build
