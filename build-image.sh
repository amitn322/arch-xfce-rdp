#!/bin/bash 
#

imageName="nt-xfce-rdesktop"

function help()
{
	echo "Usage: $0 image-name"
	
	exit 2
}

#if [ -z $1 ];then 
#   help
#fi 

docker build --progress=plain  -t ${imageName} .

