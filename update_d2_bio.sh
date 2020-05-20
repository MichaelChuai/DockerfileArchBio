#! /bin/bash

mkdir -p build-bio

cp df2_bio.Dockerfile build-bio/Dockerfile

cd build-bio/ && docker build -t bio:1.0 -t bio ./

