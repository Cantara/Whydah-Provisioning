#!/bin/sh
# Manual script to upgrade and restart application.
sudo su -c "/home/{{username}}/update-service.sh" -s /bin/sh - {{username}}
sudo initctl stop {{app_name}}
sudo initctl start {{app_name}}
