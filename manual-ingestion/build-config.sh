#!/bin/bash

IMAGESCAN_FILE=$(echo ${IMAGE_NAME}|tr "/" "_"):${IMAGE_TAG}-imagescan-cyclonedx-sbom.json
CODESCAN_URN=$(jq .serialNumber codescan-cyclonedx.json)
IMAGESCAN_URN=$(jq .serialNumber ${IMAGESCAN_FILE})

cat << EOF | envsubst > build-config.yaml
spec_version: "1.0.2"
concert:
  builds:
  - component_name: "${COMPONENT_NAME}"
    output_file: "${APP_NAME}-${COMPONENT_NAME}-build-sbom.json"
    app_name: "${APP_NAME}"
    number: 1
    version: "${APP_VERSION}"
    repositories:
    - name: "${REPO_NAME}"
      url: "${REPO_URL}"
      branch: "${REPO_BRANCH}"
      commit_sha: "${REPO_COMMIT_SHA}"
      cyclonedx_bom_link:
        file: "codescan-cyclonedx.json"
        data:
          serial_number: ${CODESCAN_URN}
          version: "1"
    image:
      name: "${IMAGE_NAME}"
      tag: "${IMAGE_TAG}"
      digest: "${IMAGE_DIGEST}"
      cyclonedx_bom_link:
        file: "${IMAGESCAN_FILE}"
        data:
          serial_number: ${IMAGESCAN_URN}
          version: "1"

EOF
