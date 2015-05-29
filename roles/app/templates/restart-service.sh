#!/bin/sh
sudo pkill -u {{username}} -f {{app_name}}
sudo initctl start {{app_name}}
