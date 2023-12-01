#!/bin/sh

mkdir -p /mnt/data/var/www

cp -r /var/www /mnt/data/var/www

mkdir -p /mnt/data/usr/bin

cp -r /usr/bin /mnt/data/usr/bin

exec /mnt/data/bin/owncloud server
