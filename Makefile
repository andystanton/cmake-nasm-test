project_name = nasm-test
image_name = debasm

all: | build

.PHONY : all

clean:
	rm -rf build

.PHONY : clean

build:
	mkdir -p build;
	cd build && cmake .. && make -j4;

.PHONY : build

runonly:
	cd build && ./$(project_name);

.PHONY : runonly

run: | all runonly

.PHONY : run

docker:
	docker build -t $(image_name) --compress .;
	docker run --rm $(image_name) make clean all run;

.PHONY : docker
