#!/bin/sh
set -x



# huggingface: distilbert
mkdir -p model_store/distilbert
rm -f model_store/distilbert/sentiment_classification.mar

model_path="download/distilbert-base-uncased-finetuned-sst-2-english"

torch-model-archiver --model-name sentiment_classification -v 1.0 \
    --serialized-file $model_path/pytorch_model.bin \
    --handler ./my_sentiment_classification_handler.py \
    --extra-files "$model_path/config.json,$model_path/vocab.txt,$model_path/tokenizer_config.json"  \
    --export-path ./model_store/distilbert

# pytorch hub: densenet
mkdir -p model_store/densenet161
rm -f model_store/densenet161/image_classification.mar

model_path="download/densenet161"

torch-model-archiver --model-name image_classification --version 1.0 \
    --serialized-file $model_path/densenet161-8d451a50.pth \
    --handler image_classifier \
    --model-file ./serve/examples/image_classifier/densenet_161/model.py \
    --extra-files ./serve/examples/image_classifier/index_to_name.json \
    --export-path ./model_store/densenet161
