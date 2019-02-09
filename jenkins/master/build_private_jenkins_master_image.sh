#!/bin/bash

PARENT_DIR=$( cd "$(dirname "${BASH_SOURCE[0]}")" ; pwd -P )
pushd $PARENT_DIR > /dev/null

set -e

PRIVATE_JENKINS_MASTER_VERSION=1.5.0

docker build -t $DOCKER_REGISTRY/jenkins-master:$PRIVATE_JENKINS_MASTER_VERSION .
docker login -u $DOCKER_USERNAME -p $DOCKER_PASSWORD $DOCKER_REGISTRY
docker push $DOCKER_REGISTRY/jenkins-master:$PRIVATE_JENKINS_MASTER_VERSION

popd > /dev/null
