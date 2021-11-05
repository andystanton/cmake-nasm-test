.PHONY : all clean build runonly run docker dockerbuild dockerclean

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

dockerbuild:
	@docker build -t $(image_name) --compress .;

docker: dockerbuild
	@docker run --rm $(image_name);

dockerclean:
	@docker rmi $(image_name);
