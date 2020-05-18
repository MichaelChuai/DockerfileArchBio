#! /bin/bash

mkdir -p build-gconda

cp gdf1_gconda.Dockerfile build-gconda/Dockerfile

cd build-gconda/ && docker build -t gconda:3.7.3 -t gconda ./
