#!/bin/sh
# Manual script to restart application.
#sudo pkill -u {{username}} -f {{app_name}}
sudo initctl stop {{app_name}}
sudo initctl start {{app_name}}
