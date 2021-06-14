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

PODMANAGER="podman"

if [[ -n $2 ]]; then
  PODMANAGER=$2

  if [[ $2 != "docker" ]] && [[ $2 != "podman" ]]; then
    echo "Second parameter have to be podman or docker."
    exit 2
  fi
fi

echo "Used pod manager: $PODMANAGER"

svc=$1

IMAGE_COMMAND="cat /dev/urandom |"

if $MAC_OS; then
  IMAGE_COMMAND="${IMAGE_COMMAND} LC_CTYPE=C"
fi

IMAGE_COMMAND="${IMAGE_COMMAND} tr -dc 'a-zA-Z0-9' | fold -w 7 | head -n 1"
image_tag=`eval "$IMAGE_COMMAND"`

#BUILDAH_LAYERS=false podman build -t ${QUAY_ROOT}/${svc} . # don't use cached layers
$PODMANAGER build -t ${QUAY_ROOT}/${svc} .

container_id=`$PODMANAGER run -d ${QUAY_ROOT}/${svc}`

$PODMANAGER commit $container_id ${QUAY_ROOT}/${svc}
$PODMANAGER tag ${QUAY_ROOT}/${svc} ${QUAY_ROOT}/${svc}:${image_tag} && $PODMANAGER push $_

echo "Finished! --------------------------------------"
echo "Quay Image: ${QUAY_ROOT}/${svc}"
echo "Quay Image Tag: ${image_tag}"
