#!/bin/bash
docker build --rm -f ./Dockerfile -t localhost:5000/object_detection:2.0 ./
docker push localhost:5000/object_detection:2.0