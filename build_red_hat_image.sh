#!/usr/bin/env bash
#
# Copyright (c) 2017-present Sonatype, Inc.
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#      http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
#

# prerequisites:
# * software:
#   * https://github.com/redhat-openshift-ecosystem/openshift-preflight
#   * https://podman.io/
# * environment variables:
#   * VERSION of the docker image  to build for the red hat registry
#   * REGISTRY_LOGIN from Red Hat config page for image
#   * REGISTRY_PASSWORD from Red Hat config page for image
#   * API_TOKEN from red hat token/account page for API access
#   * JAVA_VERSION java version to version docker images (e.g.: "java8", "java11", "java17")

set -x # log commands as they execute
set -e # stop execution on the first failed command

JAVA_8="java8"

DOCKERFILE="Dockerfile.rh.ubi"

# from config/scanning page at red hat
CERT_PROJECT_ID=5e61d90a38776799eb517bd2

REPOSITORY="quay.io"
IMAGE_LATEST="${REPOSITORY}/redhat-isv-containers/${CERT_PROJECT_ID}:latest"
IMAGE_TAG="${REPOSITORY}/redhat-isv-containers/${CERT_PROJECT_ID}:${VERSION}"
DOCKER_TAG_CMD="${IMAGE_TAG} ${IMAGE_LATEST}"

if [[ $JAVA_VERSION != $JAVA_8 ]]; then
  DOCKERFILE="Dockerfile.rh.ubi.${JAVA_VERSION}"
  IMAGE_TAG="${REPOSITORY}/redhat-isv-containers/${CERT_PROJECT_ID}:${VERSION}-${JAVA_VERSION}"
  DOCKER_TAG_CMD="${IMAGE_TAG}"
fi

AUTHFILE="${HOME}/.docker/config.json"

echo "build_red_hat_image.sh > IMAGE_LATEST ::"
echo "$IMAGE_LATEST"

echo "build_red_hat_image.sh > DOCKERFILE ::"
echo "$DOCKERFILE"

echo "build_red_hat_image.sh > IMAGE_TAG ::"
echo "$IMAGE_TAG"

echo "build_red_hat_image.sh > DOCKER_TAG_CMD ::"
echo "$DOCKER_TAG_CMD"

#docker build -f "${DOCKERFILE}" -t "${IMAGE_TAG}" .
#docker tag "${DOCKER_TAG_CMD}"
#
#docker login "${REPOSITORY}" \
#       -u "${REGISTRY_LOGIN}" \
#       --password "${REGISTRY_PASSWORD}"
#
#docker push "${IMAGE_TAG}"
#
#if [[ $JAVA_VERSION == $JAVA_8 ]]; then
#  docker push "${IMAGE_LATEST}"
#fi
#
#preflight check container \
#          "${IMAGE_TAG}" \
#          --docker-config="${AUTHFILE}" \
#          --submit \
#          --certification-project-id="${CERT_PROJECT_ID}" \
#          --pyxis-api-token="${API_TOKEN}"
