run: build
	docker run --rm -it pl1
.PHONY: run

build:
	docker build --tag pl1 .
.PHONY: build
