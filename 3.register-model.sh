#!/bin/sh
set -x

curl -X POST "http://localhost:8081/models?initial_workers=2&batch_size=1&url=sentiment_classification.mar"