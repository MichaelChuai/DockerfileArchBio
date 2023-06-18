#! /bin/bash

mkdir -p build-gbase

cp df1_gbase.Dockerfile build-gbase/Dockerfile

cd build-gbase/ && docker build -t gbase:cp310-r4-torch2-rapids -t gbase ./