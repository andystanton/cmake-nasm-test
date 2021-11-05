#!/usr/bin/env bash

pushd $(dirname $0) >/dev/null
script_path=$PWD
parent_path=$(dirname $script_path)
popd >/dev/null

pushd ${parent_path} >/dev/null

echo "Building test environment..."

make dockerbuild

echo "Running tests..."

makefile_output=$(make docker 2>dev/null)

echo "Test results..."

exit_code=1
if [ $? = 0 ] && echo "$makefile_output" | egrep -q '^Hello world$'; then
    printf "[\x1b[32m✔\x1b[0m] Test: Hello world\n"
    exit_code=0
else
    printf "[\x1b[31m✘\x1b[0m] Test: Hello world\n"
fi

echo "Cleaning up Docker image"

make dockerclean

popd >/dev/null

exit $exit_code
