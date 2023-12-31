#!/usr/bin/env bash

SCRIPT_DIR=$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )
PHOTOS_DIR="${SCRIPT_DIR}/../photos"

source "${SCRIPT_DIR}/photo-urls.env"

echo "[download-brightwheel-photos] Downloading ${#PHOTO_URLS[@]} photos from Brightwheel..."

for PHOTO_URL in "${PHOTO_URLS[@]}"; do
    FILENAME="${PHOTO_URL:50:11}";
    FILENAME="${FILENAME//\//}.jpg"
    LOCAL_PHOTO_PATH="${PHOTOS_DIR}/${FILENAME}"
    PHOTO_TIMESTAMP=$(echo "${PHOTO_URL}" | cut -d '?' -f 2)
    PHOTO_DATE=$(date -r "${PHOTO_TIMESTAMP}" '+%Y-%m-%dT%H:%M:%S')

    if [ -f "${LOCAL_PHOTO_PATH}" ]; then
        echo "[download-brightwheel-photos] Skipping download for ${PHOTO_URL} (file already exists)"
    else
        curl -so "${LOCAL_PHOTO_PATH}" "${PHOTO_URL}" && echo "[download-brightwheel-photos] Downloaded ${PHOTO_URL} -> ${LOCAL_PHOTO_PATH}"
    fi

    touch -d "${PHOTO_DATE}" "${LOCAL_PHOTO_PATH}" && echo "[download-brightwheel-photos] Set date for ${LOCAL_PHOTO_PATH} to ${PHOTO_DATE}"
done

echo "[download-brightwheel-photos] Done!"
