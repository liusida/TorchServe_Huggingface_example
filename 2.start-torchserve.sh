#!/bin/sh
set -x

echo "Press Ctrl+C to stop the service"
torchserve --start --model-store model_store --models sentiment_classification --foreground
