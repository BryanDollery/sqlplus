.PHONY: all build test

.DEFAULT_GOAL := all

all: build test

build: 
	DOCKER_BUILDKIT=1 docker build -t sqlplus . 

test:
	./test.sh
