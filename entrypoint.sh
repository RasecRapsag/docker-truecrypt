#!/usr/bin/env sh

mkdir /mnt/truecrypt

mknod /dev/loop0 b 7 0
losetup -f 

tail -f /dev/null
