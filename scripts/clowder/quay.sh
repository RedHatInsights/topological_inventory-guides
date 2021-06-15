#!/bin/bash
# Usage: cd <svc dir>; export QUAY_ROOT=...; ./quay.sh <svc>
# Example: cd sources-api; export QUAY_ROOT=quay.io/mslemr; ../scripts/clowder/quay.sh sources-api

if [[ -z $QUAY_ROOT ]]; then
  echo "Please export QUAY_ROOT=\"quay.io/<username>\" first"
  exit
fi

if [[ "$(uname)" == "Darwin" ]]; then
  MAC_OS=true
else
  MAC_OS=false
fi

IMAGE_BUILDER="podman"

if [[ -n $2 ]]; then
  IMAGE_BUILDER=$2

  if [[ $2 != "docker" ]] && [[ $2 != "podman" ]]; then
    echo "Second parameter have to be podman or docker."
    exit 2
  fi
fi

echo "Used image builder: $IMAGE_BUILDER"

CACHE=true

if [[ $3 == "no-cache" ]]; then
  CACHE=false
fi

svc=$1

IMAGE_COMMAND="cat /dev/urandom |"

if $MAC_OS; then
  IMAGE_COMMAND="${IMAGE_COMMAND} LC_CTYPE=C"
fi

IMAGE_COMMAND="${IMAGE_COMMAND} tr -dc 'a-zA-Z0-9' | fold -w 7 | head -n 1"
image_tag=`eval "$IMAGE_COMMAND"`

if $CACHE; then
  $IMAGE_BUILDER build -t ${QUAY_ROOT}/${svc} .
else
  if [[ IMAGE_BUILDER == "podman" ]]; then
    BUILDAH_LAYERS=false podman build -t ${QUAY_ROOT}/${svc} . # don't use cached layers
  else
    docker build -t ${QUAY_ROOT}/${svc} . --no-cache
  fi
fi

container_id=`$IMAGE_BUILDER run -d ${QUAY_ROOT}/${svc}`

$IMAGE_BUILDER commit $container_id ${QUAY_ROOT}/${svc}
$IMAGE_BUILDER tag ${QUAY_ROOT}/${svc} ${QUAY_ROOT}/${svc}:${image_tag} && $IMAGE_BUILDER push $_

echo "Finished! --------------------------------------"
echo "Quay Image: ${QUAY_ROOT}/${svc}"
echo "Quay Image Tag: ${image_tag}"
