#/bin/sh
set -x

BASE_SERVE_PORT=9001
BASE_MANAGE_PORT=10001

# huggingface: distilbert
docker run -d --rm --name=torchserve-distilbert \
    --shm-size=1g --ulimit memlock=-1 --ulimit stack=67108864 \
    -p$(expr $BASE_SERVE_PORT + 0):8080 \
    -p$(expr $BASE_MANAGE_PORT + 0):8081 \
    --mount type=bind,source=$PWD/model_store,target=/tmp/models \
    pytorch/torchserve:latest-cpu \
    torchserve --model-store=/tmp/models --models sentiment_classification.mar

# pytorch hub: densenet
docker run -d --rm --name=torchserve-densenet \
    --shm-size=1g --ulimit memlock=-1 --ulimit stack=67108864 \
    -p$(expr $BASE_SERVE_PORT + 1):8080 \
    -p$(expr $BASE_MANAGE_PORT + 1):8081 \
    --mount type=bind,source=$PWD/model_store,target=/tmp/models \
    pytorch/torchserve:latest-cpu \
    torchserve --model-store=/tmp/models --models densenet161.mar

