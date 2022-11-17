#!/bin/sh

#!/bin/sh
# ssh into the target through the EC2 instance assuming it is on and port
# forwarding has already been setup by the target
# Usage:
#   ./connect_to_target.sh [keypath] [port] [instance_ip]
# Author:
#   James Bohn

set -e

default_keypath="ec2_key.priv"
default_port="8022"
default_instance_ip="34.224.219.227"

keypath=${1:-${default_keypath}}
port=${2:-${default_port}}
instace_ip=${3:-${default_instance_ip}}

ssh -i ${keypath} -p ${port} root@${instace_ip}
