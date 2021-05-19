#!/bin/sh
set -x

mkdir -p model_store
rm -f model_store/sentiment_classification.mar

model_path="distilbert-base-uncased-finetuned-sst-2-english"

torch-model-archiver --model-name sentiment_classification -v 1.0 \
    --serialized-file $model_path/pytorch_model.bin \
    --handler ./my_sentiment_classification_handler.py \
    --extra-files "$model_path/config.json,$model_path/vocab.txt,$model_path/tokenizer_config.json"  \
    --export-path ./model_store
