#!/bin/bash

cat << EOF | envsubst > app-config.yaml
spec_version: "1.0.2"
concert:
  application:
    output_file: "${APP_NAME}-${COMPONENT_NAME}-app-definition-sbom.json"
    app_name: "${APP_NAME}"
    version: "${APP_VERSION}"
    business:
      name: "${BUSINESS_NAME}"
      units:
      - name: "${BUSINESS_UNIT}"
        email: "${BUSINESS_EMAIL}"
        phone: "${BUSINESS_PHONE}"
    properties:
      application_criticality: "${APP_CRITICALITY}"
    components:
    - component_name: "${COMPONENT_NAME}"
      version: "${APP_VERSION}"
      repositories:
      - name: "${REPO_NAME}"
        url: "${REPO_URL}"
      image:
        name: "${IMAGE_NAME}"
    environment_targets:
    - name: "${ENV_TARGET}"
    services:
    - name: "${ACCESS_POINT_NAME}"
      type: "app_end_point"
      endpoints: 
      - "${APP_ENDPOINT}"
      properties:
        network_exposure: "${APP_ENDPOINT_EXPOSURE}"
      reliant_by:
      - "${COMPONENT_NAME}"
EOF

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

cat << EOF | envsubst > deploy-config.yaml
spec_version: "1.0.2"
concert:
  deployments:
  - output_file: "${APP_NAME}-${COMPONENT_NAME}-deploy-sbom.json"
    metadata:
      component_name: "${COMPONENT_NAME}"
      number: "1"
      version: "${APP_VERSION}"
    environment_target: "${ENV_TARGET}"
    repositories:
    - name: "${REPO_NAME}"
      url: "${REPO_URL}"
      branch: "${REPO_BRANCH}"
      commit_sha: "${REPO_COMMIT_SHA}"
    services:
    - name: "${ACCESS_POINT_NAME}"
      type: "app_access_point"
      properties:
        base_url: "${APP_URL}"
    runtime:
    - name: "${K8S_NAME}"
      type: "kubernetes"
      depends_on: 
      - "${COMPONENT_NAME}"
      properties:
        platform: "${K8S_PLATFORM}"
        cluster_platform: "${K8S_ENV_PLATFORM}"
        cluster_id: "${K8S_CLUSTER_ID}"
        cluster_region: "${K8S_CLUSTER_REGION}"
        cluster_name: "${K8S_CLUSTER_NAME}"
      api-server: ${K8S_APISERVER}
      namespaces:
      - name: "${K8S_NAMESPACE}"
        images:
        - name: "${IMAGE_NAME}"
          tag: "${IMAGE_TAG}"
          digest: "${IMAGE_DIGEST}"

EOF

cat << EOF | envsubst > config.yaml
general:
  retries: 3
  timeout: 30
  verbose: true
  insecure: true
app:
  base_url: "${BASE_URL}"
  instance_id: "0000-0000-0000-0000"
EOF

if [[ -z ${TOKEN} ]]; then 
  cat << EOF | envsubst >> config.yaml
  auth:
    user:
      username: ${CONCERT_USERNAME}
      password: ${CONCERT_PASSWORD}
EOF
else
  cat << EOF | envsubst >> config.yaml
  auth:
    token:
      token: ${TOKEN}
EOF
fi

cat << EOF | envsubst >> config.yaml
input-data:
  application-def:
    - file: "/toolkit-data/${APP_NAME}-${COMPONENT_NAME}-app-definition-sbom.json"
  build:
    - file: "/toolkit-data/${APP_NAME}-${COMPONENT_NAME}-build-sbom.json"
  deploy:
    - file: "/toolkit-data/${APP_NAME}-${COMPONENT_NAME}-deploy-sbom.json"
  cyclonedx:
    - file: "/toolkit-data/codescan-cyclonedx.json"
    - file: "/toolkit-data/$(echo ${IMAGE_NAME}|tr "/" "_"):${IMAGE_TAG}-imagescan-cyclonedx-sbom.json"
  image-scan:
    - file: "/toolkit-data/cve-scan.json"
      metadata:
        scanner_name: "trivy"
EOF
