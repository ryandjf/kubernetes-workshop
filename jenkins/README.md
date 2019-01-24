
## Jenkins

```

kubectl create secret generic registry-generic-secret --from-literal=username=admin --from-literal=password=123

```

### For our first deployment I'm going to comment the jenkins_home volume mount.
```
kubectl apply -f jenkins.yaml
```

### Create the persistence for jenkins_home

While jenkins is running connect on the server where the nodeSelector is pointing to.

Now we have to find the container where Jenkins is running:

```
sudo docker ps  | grep jenkins
```

```
a80da2e388e1        robertbrem/jenkins:1.0.2                           "/bin/bash -c ./run.s"   2 minutes ago       Up 2 minutes                            k8s_jenkins.f24a85d5_jenkins-1074834219-nqlfc_default_ec99c5d7-c941-11e6-a836-0050563cad2a_5e2790be
157591884d20        gcr.io/google_containers/pause-amd64:3.0           "/pause"                 5 minutes ago       Up 5 minutes                            k8s_POD.d8dbe16c_jenkins-1074834219-nqlfc_default_ec99c5d7-c941-11e6-a836-0050563cad2a_569a356a
```
In our case this is a80da2e388e1. Now we copy the content of jenkins_home on the server.

```
sudo docker cp a80da2e388e1:/var/jenkins_home ~/.
```
That the container can use this mount we have to change the rights of the folder.

```
sudo chown -R 1000:1000 ~/jenkins_home/
```


### Start Jenkins with the jenkins_home mount
Now we can stop the current Jenkins deployment:
```
kubectl delete -f jenkins.yaml
```
Then we uncomment the previously commented lines of the deployment and redeploy it.
```
kubectl create -f jenkins.yaml
```
