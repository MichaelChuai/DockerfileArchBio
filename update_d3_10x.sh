#! /bin/bash

mkdir -p build-10x

cp df3_10x.Dockerfile build-10x/Dockerfile

cd build-10x/ && docker build -t bio-10x:1.0 -t bio-10x ./

