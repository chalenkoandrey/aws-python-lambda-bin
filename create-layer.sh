#!/bin/bash
set -euo pipefail

cd $(dirname $0)

# echo ">> Building AWS Lambda layer inside a docker image..."

TAG='lambda-layer'

docker buildx build --platform linux/amd64 -t ${TAG} .

echo ">> Extracting layer.zip from the build container..."
CONTAINER=$(docker run -d --platform linux/amd64 ${TAG} false)
docker cp ${CONTAINER}:/kubectl_layer.zip layer.zip

echo ">> Stopping container..."
docker rm -f ${CONTAINER}
echo ">> layer.zip is ready"
