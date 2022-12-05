#!/bin/sh

#!/bin/sh
# ssh into the target through the EC2 instance assuming it is on and port
# forwarding has already been setup by the target
# Usage:
#   ./connect_to_target.sh [keypath] [port] [instance_ip]
# Author:
#   James Bohn

set -e

keypath="ec2_key.priv"
port="8022"
instance_ip="34.224.219.227"
instance_id="i-0ab8a29017bb737a7"

while [ $# -gt 0 ]; do
    case "$1" in
        -k)
            shift
            keypath=$1
            shift
            ;;
        -p)
            shift
            port=$1
            shift
            ;;
        -i)
            shift
            instace_ip=$1
            shift
            ;;
        -s)
            aws ec2 start-instances --instance-ids ${instance_id} 
            while [ $(aws ec2 describe-instance-status --instance-ids ${instance_id} | grep -c running) -eq 0 ]; do
                sleep 1
            done
            shift
            ;;
        -ss)
            shift
            instance_id=$1
            aws ec2 start-instances --instance-ids ${instance_id} 
            while [ $(aws ec2 describe-instance-status --instance-ids ${instance_id} | grep -c running) -eq 0 ]; do
                sleep 1
            done
            shift
            ;;
        *)
            break
            ;;
    esac
done

ssh -i ${keypath} -p ${port} root@${instance_ip}
