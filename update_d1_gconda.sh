#! /bin/bash

mkdir -p build-gconda

cp df1_gconda.Dockerfile build-gconda/Dockerfile

cd build-gconda/ && docker build -t gconda:3.9.7 -t gconda ./
