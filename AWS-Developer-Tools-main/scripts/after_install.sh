#!/bin/bash
EC2_INSTANCE_ID=$(i-0b9816bc51c2dc387)
EC2_AZ=$(ap-south-2a)
sed -i "s/was deployed/was deployed on $EC2_INSTANCE_ID in $EC2_AZ/g" /var/www/html/index.html
chmod 664 /var/www/html/index.html
# #
