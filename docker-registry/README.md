## Create EC2 EBS for persistence storage
```

aws ec2 create-volume --availability-zone $AZ --size $VOL_SIZE --volume-type gp2

```

## Create password file
```
mkdir -p ~/registry/{images,certs,auth}
sudo docker run --entrypoint htpasswd registry:2 -Bbn admin 123 > ~/registry/auth/htpasswd
```

## Test Private Registry
```

export TEST_PRIVATE_REGISTRY=ec2-54-223-111-211.cn-north-1.compute.amazonaws.com.cn:30500

docker login -u admin -p 123 "${TEST_PRIVATE_REGISTRY}"

docker pull alpine:3.5
docker tag alpine:3.5 "${TEST_PRIVATE_REGISTRY}/my-alpine"
docker push "${TEST_PRIVATE_REGISTRY}/my-alpine"
docker image remove alpine:3.5
docker image remove "${TEST_PRIVATE_REGISTRY}/my-alpine"
docker pull "${TEST_PRIVATE_REGISTRY}/my-alpine"
docker images
```

## Use Private Registry in K8S
### Create a Secret in the cluster that holds your authorization token
```

kubectl create secret docker-registry registry-secret --docker-server=ec2-52-80-8-7.cn-north-1.compute.amazonaws.com.cn:30500 --docker-username=admin --docker-password=123 --docker-email=admin@tw.com

```
### Create a Pod that uses your Secret
```
 imagePullSecrets:
  - name: registry-secret
```

