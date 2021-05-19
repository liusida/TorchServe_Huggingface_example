# TorchServe_Huggingface_example

Learning how to make a Huggingface handler for TorchServe

## Usage without Docker:

```bash
./0.download-model-from-huggingface.sh

./1.make-archiver.sh

./2.start-torchserve.sh
```
Then, wait until the server started.
Open another terminal:
```bash
./3.register-model.sh
```

## Usage with Docker:

```bash
./0.download-model-from-huggingface.sh

./1.make-archiver.sh

cd docker
sh ./build_image.sh
cd ..

./2.start-docker-torchserve.sh
```
Then, wait until the server started.
Open another terminal:
```bash
./3.register-model.sh
```


## API:

Postman Documentation:

[https://documenter.getpostman.com/view/9297280/TzRYdQmu](https://documenter.getpostman.com/view/9297280/TzRYdQmu)