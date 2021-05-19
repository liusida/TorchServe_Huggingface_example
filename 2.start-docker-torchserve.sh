#/bin/sh
set -x

docker run -it --rm --name=torchserve \
    --shm-size=1g --ulimit memlock=-1 --ulimit stack=67108864 \
    -p8080:8080 \
    -p8081:8081 \
    -p8082:8082 \
    -p7070:7070 \
    -p7071:7071 \
    --mount type=bind,source=$PWD/model_store,target=/tmp/models \
    --mount type=bind,source=$PWD/logs,target=/home/model-server/logs \
    pytorch/torchserve:latest-cpu \
    torchserve --model-store=/tmp/models
