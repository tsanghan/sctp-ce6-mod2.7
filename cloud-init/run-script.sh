#!/usr/bin/env bash

sed -i '/Further configuration is required.<\/p>/s#Further configuration is required.</p>#Further configuration is required.</p>\n\n<h1>This is added by Cloud-init.</h1>#' /var/www/html/index.nginx-debian.html