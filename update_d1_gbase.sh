#! /bin/bash

mkdir -p build-gbase

cp df1_gbase.Dockerfile build-gbase/Dockerfile

cd build-gbase/ && docker build -t gbase:3.9.7 -t gbase ./
