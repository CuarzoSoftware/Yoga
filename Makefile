
N_CPUS = $(shell nproc)

.PHONY: setup build install clean

all: setup build install

setup:
	cmake -S . -B build

build:
	cmake --build build -- -j $(N_CPUS)

install:
	sudo cmake --install build

clean:
	rm -rf build
