#!/bin/bash

if pgrep -x "nginx" >/dev/null
then
    /etc/init.d/nginx reload
fi
