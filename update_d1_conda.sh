#! /bin/bash

mkdir -p build-conda

cp df1_conda.Dockerfile build-conda/Dockerfile

cd build-conda/ && docker build -t conda:3.7.3 -t conda ./
