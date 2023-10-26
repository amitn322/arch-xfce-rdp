#!/bin/bash
#
package_filename="packages.txt"

while read -r packageName; do
	echo "Package Name: $packageName"    
	yes | yay -Sy ${packageName} --answerclean All --answerdiff All
done < "${package_filename}"
