#! /bin/bash

mkdir -p build-gym

cp gdf2_gym.Dockerfile build-gym/Dockerfile

cd build-gym/ && docker build -t gym ./

