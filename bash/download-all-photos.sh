#!/usr/bin/env bash

SCRIPT_DIR=$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )
PHOTOS_DIR="${SCRIPT_DIR}/../photos"

source "${SCRIPT_DIR}/photo-urls.env"

echo "[download-brightwheel-photos] Downloading ${#PHOTO_URLS[@]} photos from Brightwheel..."

for PHOTO_URL in "${PHOTO_URLS[@]}"; do
    FILENAME="${PHOTO_URL:50:11}";
    FILENAME="${FILENAME//\//}.jpg"
    LOCAL_PHOTO_PATH="${PHOTOS_DIR}/${FILENAME}"

    curl -so "${LOCAL_PHOTO_PATH}" "${PHOTO_URL}" && echo "[download-brightwheel-photos] ${PHOTO_URL} -> ${LOCAL_PHOTO_PATH}"
done

echo "[download-brightwheel-photos] Done!"
