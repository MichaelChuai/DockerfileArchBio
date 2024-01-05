#! /bin/bash

mkdir -p build-dl

cp df2a_dl.Dockerfile build-dl/Dockerfile

cd build-dl/ && docker build -t dl:1.0 -t dl ./

