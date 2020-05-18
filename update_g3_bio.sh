#! /bin/bash

mkdir -p build-bio

cp gdf3_bio.Dockerfile build-bio/Dockerfile

cd build-bio/ && docker build -t bio ./

