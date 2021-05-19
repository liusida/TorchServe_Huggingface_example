#/bin/sh
set -x

if [ -z "$1" ]; then
    # by default
    PORT=8080
    MODE="it"
else
    # this is just for me
    PORT=$1
    MODE="d"
fi

docker run -${MODE} --rm --name=torchserve \
    --shm-size=1g --ulimit memlock=-1 --ulimit stack=67108864 \
    -p${PORT}:8080 \
    -p8081:8081 \
    -p8082:8082 \
    -p7070:7070 \
    -p7071:7071 \
    --mount type=bind,source=$PWD/model_store,target=/tmp/models \
    pytorch/torchserve:latest-cpu \
    torchserve --model-store=/tmp/models
