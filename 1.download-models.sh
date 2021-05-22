#!/bin/sh
set -x

# huggingface: distilbert
git lfs install
git clone https://huggingface.co/distilbert-base-uncased-finetuned-sst-2-english

# pytorch hub: densenet
mkdir -p tmp
wget https://download.pytorch.org/models/densenet161-8d451a50.pth -O tmp/densenet161-8d451a50.pth
