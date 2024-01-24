#!/bin/bash

##database backup

sudo -i -u postgres pg_dump databasename | gzip > /var/lib/postgresql/database_name`date +%d-%m-%y`.gz

if rsync -avz -e 'sshpass -p "target_password" ssh -p 22 -o StrictHostKeyChecking=no' /var/lib/postgresql/database_name`date +%d-%m-%y`.gz  target_username@target_ip_address:/target_path/.   ; then
        rm -rf /var/lib/postgresql/database_name`date +%d-%m-%y`.gz
        echo "database_name database backup done"  | sendmail -f 'alert mail id' -t example.com
        exit 0
else

        echo "database_name Backup upload failed" | sendmail -f example.com -t example.com
        exit 0

fi

