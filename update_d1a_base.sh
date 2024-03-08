#! /bin/bash

mkdir -p build-base

cp df1a_base.Dockerfile build-base/Dockerfile

cd build-base/ && docker build -t base:py3.11 -t base ./
