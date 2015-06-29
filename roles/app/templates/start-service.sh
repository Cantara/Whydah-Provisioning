#!/bin/sh
# Start script used by upstart. Should not be called directly if upstart is used. NOT CURRENTLY IN USE!
# TODO Decide if this should be used by upstart or not.
nohup /usr/bin/java {{env_vars}} -jar /home/{{username}}/{{app_name}}.jar &