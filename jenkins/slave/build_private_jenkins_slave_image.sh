#!/bin/bash

PARENT_DIR=$( cd "$(dirname "${BASH_SOURCE[0]}")" ; pwd -P )
pushd $PARENT_DIR > /dev/null

set -e

PRIVATE_JENKINS_SLAVE_VERSION=1.0.0

docker build -t $DOCKER_REGISTRY/jenkins-slave:$PRIVATE_JENKINS_SLAVE_VERSION .
docker login -u $DOCKER_USERNAME -p $DOCKER_PASSWORD $DOCKER_REGISTRY
docker push $DOCKER_REGISTRY/jenkins-slave:$PRIVATE_JENKINS_SLAVE_VERSION

popd > /dev/null
