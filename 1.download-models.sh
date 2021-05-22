#!/bin/sh
set -x

# huggingface: distilbert
git lfs install
git clone https://huggingface.co/distilbert-base-uncased-finetuned-sst-2-english download/distilbert-base-uncased-finetuned-sst-2-english

# pytorch hub: densenet
mkdir -p download/densenet161
wget https://download.pytorch.org/models/densenet161-8d451a50.pth -O download/densenet161/densenet161-8d451a50.pth
