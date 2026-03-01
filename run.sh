#!/bin/sh
set -e

# Persistente Daten in /share/dokuwiki
mkdir -p /share/dokuwiki/data/pages
mkdir -p /share/dokuwiki/data/attic
mkdir -p /share/dokuwiki/data/media
mkdir -p /share/dokuwiki/data/media_attic
mkdir -p /share/dokuwiki/data/media_meta
mkdir -p /share/dokuwiki/data/meta
mkdir -p /share/dokuwiki/data/locks
mkdir -p /share/dokuwiki/data/log
mkdir -p /share/dokuwiki/data/index
mkdir -p /share/dokuwiki/data/tmp
mkdir -p /share/dokuwiki/data/cache
mkdir -p /share/dokuwiki/conf
mkdir -p /share/dokuwiki/tpl
mkdir -p /share/dokuwiki/plugins

# Original-Konfig kopieren falls conf leer ist
if [ ! -f /share/dokuwiki/conf/dokuwiki.php ]; then
    cp -r /var/www/dokuwiki.dist/conf/* /share/dokuwiki/conf/
fi

# Standard-Template kopieren falls tpl leer ist
if [ ! -d /share/dokuwiki/tpl/dokuwiki ]; then
    cp -r /var/www/dokuwiki.dist/lib/tpl/dokuwiki /share/dokuwiki/tpl/
fi

# Standard-Plugins kopieren falls plugins leer ist
if [ ! -d /share/dokuwiki/plugins/config ]; then
    cp -r /var/www/dokuwiki.dist/lib/plugins/* /share/dokuwiki/plugins/
fi

# Berechtigungen setzen
chown -R nobody:nobody /share/dokuwiki

# Symlinks zu persistenten Daten
rm -rf /var/www/dokuwiki/data
rm -rf /var/www/dokuwiki/conf
rm -rf /var/www/dokuwiki/lib/tpl
rm -rf /var/www/dokuwiki/lib/plugins

ln -sf /share/dokuwiki/data /var/www/dokuwiki/data
ln -sf /share/dokuwiki/conf /var/www/dokuwiki/conf
ln -sf /share/dokuwiki/tpl /var/www/dokuwiki/lib/tpl
ln -sf /share/dokuwiki/plugins /var/www/dokuwiki/lib/plugins

# PHP-FPM starten
php-fpm83 -D

# Nginx starten
exec nginx -g 'daemon off;'