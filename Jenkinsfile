#!/bin/bash
EC2_INSTANCE_ID=$('i-0b9816bc51c2dc387')
EC2_AZ=$('ap-south-1')
sed -i -e "s/was deployed/was deployed on $EC2_INSTANCE_ID in $EC2_AZ/g" /var/www/html/index.html"
chmod 664 /var/www/html/index.html

sudo apt install apache2 -y

sudo service apache2 start

sudo service apache2 stop


# verify we can access our webpage successfully
curl -v --silent localhost:80 2>&1 | grep DevOpsBuildDemo




