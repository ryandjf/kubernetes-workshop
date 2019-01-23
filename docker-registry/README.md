* Create EC2 EBS for persistence storage
```
aws ec2 create-volume --availability-zone $AZ --size $VOL_SIZE --volume-type gp2
```
