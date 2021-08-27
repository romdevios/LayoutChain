#!/bin/sh

while getopts ":v:" opt; do
  case $opt in
    v) 
	version="$OPTARG"
	echo "push git version: $version"
	git push;
	git tag $version;
 	git push --tag;
    ;;
    \?) 
	echo "Invalid option -$OPTARG" >&2
	exit 1
    ;;
  esac
done

# check arguments count
if [ "$#" -eq 1 ]; then
 echo "USAGE: $0 -v VERSION"
  exit 1
fi

pod repo push LayoutChain LayoutChain.podspec