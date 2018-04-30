.PHONY : all clean build runonly run docker

project_name = nasm-test
image_name = debasm

all: | build

clean:
	@rm -rf build

build:
	@mkdir -p build;
	@cd build && cmake .. && make -s -j4;

runonly:
	@cd build && ./$(project_name);

run: | all runonly

docker:
	@docker build -t $(image_name) --compress .;
	@docker run --rm $(image_name) make -s clean all run;
