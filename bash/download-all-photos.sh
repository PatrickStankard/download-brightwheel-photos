#!/usr/bin/env bash

SCRIPT_DIR=$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )
PHOTOS_DIR="${SCRIPT_DIR}/../photos"

source "${SCRIPT_DIR}/photo-urls.env"

echo "[download-brightwheel-photos] Downloading ${#PHOTO_URLS[@]} photos from Brightwheel..."

for PHOTO_URL in "${PHOTO_URLS[@]}"; do
    FILENAME="${PHOTO_URL:50:11}";
    FILENAME="${FILENAME//\//}.jpg"
    LOCAL_PHOTO_PATH="${PHOTOS_DIR}/${FILENAME}"

    if [ -f "${LOCAL_PHOTO_PATH}" ]; then
        echo "[download-brightwheel-photos] Skipping ${PHOTO_URL} (file already exists)"
    else
        curl -so "${LOCAL_PHOTO_PATH}" "${PHOTO_URL}" && echo "[download-brightwheel-photos] Downloaded ${PHOTO_URL} -> ${LOCAL_PHOTO_PATH}"
    fi
done

echo "[download-brightwheel-photos] Done!"
