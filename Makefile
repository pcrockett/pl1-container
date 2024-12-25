PLATFORM = linux/386
TAG = pl1

all: build run
.PHONY: all

run:
	docker run --rm -it \
		--privileged \
		--platform "${PLATFORM}" \
		--volume .:/app \
		"${TAG}"
.PHONY: run

build:
	docker build --platform "${PLATFORM}" --tag "${TAG}" .
.PHONY: build

ci: clean build
	docker run --rm -it \
		--privileged \
		--platform "${PLATFORM}" \
		--volume .:/app \
		"${TAG}" \
		./test-programs/TEST.sh
.PHONY: ci

clean:
	rm -f test-programs/*.lst test-programs/LOADLIB/*
.PHONY: clean
