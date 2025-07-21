#### Concert Toolkit Image
####
export CONCERT_TOOLKIT_IMAGE=icr.io/cpopen/ibm-concert-toolkit:v1.0.4

#### Concert details
####
#export BASE_URL="https://<YOUR_CONCERT_VM_PUBLIC_IP>:12443"
#export CONCERT_USERNAME="<YOUR_CONCERT_USERNAME>"
#export CONCERT_PASSWORD="<YOUR_CONCERT_PASSWORD>"
# If running Concert on OpenShift
export BASE_URL="https://concert-concert-instance.apps.679269c5f501a868a5829497.ocp.techzone.ibm.com/ibm/concert"
export TOKEN="ZenApiKey Y3BhZG1pbjpGOHZCeEtjQ1dPczlnN1lRaDZLb2VHS3M1eFBqWU90c04xYk5KSEhP"
####
# cyclonedx generation utility for source code
####
export OUTPUTDIR=/home/ibmuser/install/concert-enablement
export SRC_PATH=./qotd-web

######

# Application Variables
###
export APP_NAME=qotd-app
export APP_VERSION=1.0.0
export APP_CRITICALITY=5
export COMPONENT_NAME=qotd-web
export COMPONENT_VERSION=4.1.0
export ENVIRONMANET_NAME_1=qa
export ENVIRONMANET_NAME_2=stage
export ENVIRONMANET_NAME_3=prod

#### inventory specific variable
###
export REPO_NAME=qotd-web
export REPO_URL=https://github.com/IBM/concert-enablement/tree/main/qotd-web
export REPO_BRANCH=main
export REPO_COMMIT_SHA=bb597bb119e9a3e426d82b4527ae003520c2ca94
export BUILD_NUMBER=1
export IMAGE_NAME=quay.io/concert-enablement/qotd-web
export IMAGE_TAG=latest
export IMAGE_DIGEST="sha256:de0583ea23cb5548f4348ec565fb0d304dbd13e92a95cf07472efb677b9dc919"
###

# deploy/release specific variable

###
export ENV_TARGET=production
export DEPLOYMENT_REPO_NAME=https://github.com/IBM/concert-enablement/tree/main/qotd-web
export K8_PLATFORM=0cр
export CLUSTER_ENV_PLATFORM=techzone
export CLUSTER_ID=19350ff9-8f6c-4624-861f-d5b556d7d092
export CLUSTER REGION=
export CLUSTER NAME=sila
export CLUSTER_NAMESPACE=qotd-app
export APP_URL=${COMPONENT_NAME}-qotd-app.apps.679269c5f501a868a5829497.ocp.techzone.ibm.com
export ENVIRONMENT_TARGET=production
export BUSINESS_NAME="IBM"
export BUSINESS_UNIT="IBM Technology"
export BUSINESS_EMAIL="your-email-here@us.ibm.com"
export BUSINESS_PHONE="123-456-7890"
export ACCESS_POINT_NAME="qotd-web"
export APP_ENDPOINT="/qotd-web"
export APP_ENDPOINT_EXPOSURE="public"
export K8S_NAME=concert-aws-prod-us-east-2
export K8S_PLATFORM=ocp
export K8S_ENV_PLATFORM=aws
export K8S_CLUSTER_ID=concert-nv4pj
export K8S_CLUSTER_REGION=us-east-2
export K8S_CLUSTER_NAME=concert
export K8S_NAMESPACE=qotd
export CONTAINER_COMMAND="podman run"
export OPTIONS="--platform linux/amd64 -it --rm -u 0"
