#!/bin/bash
echo "Collecting aws facts..............."
hosts=`aws ec2 describe-instances --filters Name=tag:Name,Values="ec2 instance" | grep -iw PublicIp | awk '{print $2}' | sed -e 's/"//g' -e 's/,//' | sort -n | uniq`
dbendpoint=`aws rds describe-db-instances --db-instance-identifier mariadb | grep Address | awk '{print $2}' | sed 's/"//g'`
echo "[web]" >/home/ec2-user/hosts
for i in `echo $hosts`
do
echo "$i ansible_user=ec2-user ansible_ssh_private_key_file=/home/ec2-user/webtierkey.pem" >>/home/ec2-user/hosts

done

sed -i 's/localhost/'$dbendpoint'/' wp-config.php

echo "Starting modifications....................."
ansible-playbook -i /home/ec2-user/hosts dbconnection.yaml

#sed -i 's/'$dbendpoint'/localhost/' wp-config.php
