#! /bin/bash

mkdir -p build-gym

cp df3_gym.Dockerfile build-gym/Dockerfile

cd build-gym/ && docker build -t gym:1.0 -t gym ./

