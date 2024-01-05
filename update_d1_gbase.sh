#! /bin/bash

mkdir -p build-gbase

cp df1_gbase.Dockerfile build-gbase/Dockerfile

cd build-gbase/ && docker build -t gbase:py3.11-torch2.1-r4 -t gbase ./