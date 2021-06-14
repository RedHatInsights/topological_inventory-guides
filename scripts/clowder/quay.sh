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

svc=$1

IMAGE_COMMAND="cat /dev/urandom |"

if $MAC_OS; then
  IMAGE_COMMAND="${IMAGE_COMMAND} LC_CTYPE=C"
fi

IMAGE_COMMAND="${IMAGE_COMMAND} tr -dc 'a-zA-Z0-9' | fold -w 7 | head -n 1"
image_tag=`eval "$IMAGE_COMMAND"`

#BUILDAH_LAYERS=false podman build -t ${QUAY_ROOT}/${svc} . # don't use cached layers
podman build -t ${QUAY_ROOT}/${svc} .
podman run -d ${QUAY_ROOT}/${svc}
container_id=`podman ps -l | grep "${QUAY_ROOT}/${svc}" | awk '{print $1}'`

podman commit $container_id ${QUAY_ROOT}/${svc}
podman tag ${QUAY_ROOT}/${svc} ${QUAY_ROOT}/${svc}:${image_tag} && podman push $_

echo "Finished! --------------------------------------"
echo "Quay Image: ${QUAY_ROOT}/${svc}"
echo "Quay Image Tag: ${image_tag}"
