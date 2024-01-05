#! /bin/bash

mkdir -p build-test

cp df1_test.Dockerfile build-test/Dockerfile

cd build-test/ && docker build -t test ./