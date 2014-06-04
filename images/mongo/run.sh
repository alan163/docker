#!/bin/bash
/usr/sbin/sshd 
/usr/bin/supervisord -c /supervisord.conf -n
