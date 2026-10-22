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

# Mitgelieferte Teile bei jedem Start auf die DokuWiki-Version des Images bringen. Sie liegen dauerhaft unter
# /share; stammen sie aus einer anderen Version als der Kern (nach einem Add-on-Update oder einem Upgrade über das
# Wiki), bricht jede Seite mit einem PHP-Fehler ab. Eigene Dateien (local.php, acl.auth.php, users.auth.php,
# plugins.local.php, *.local.conf), installierte Plugins und andere Templates bleiben unberührt.
DIST=/var/www/dokuwiki.dist
DOKUWIKI_VERSION="$(cat "$DIST/VERSION")"
echo "DokuWiki ${DOKUWIKI_VERSION}: mitgelieferte Plugins, Standard-Template und Standard-Konfiguration abgleichen"

# Standard-Konfiguration (nur Vorgaben, die DokuWiki bei Upgrades selbst überschreibt)
cp -f "$DIST"/conf/* /share/dokuwiki/conf/

# Standard-Template
rm -rf /share/dokuwiki/tpl/dokuwiki
cp -r "$DIST/lib/tpl/dokuwiki" /share/dokuwiki/tpl/
cp -f "$DIST/lib/tpl/index.php" /share/dokuwiki/tpl/

# Mitgelieferte Plugins einzeln ersetzen, damit keine veralteten Dateien zurückbleiben
for src in "$DIST"/lib/plugins/*; do
    [ -e "$src" ] || continue
    name="$(basename "$src")"
    [ -n "$name" ] || continue
    rm -rf "/share/dokuwiki/plugins/${name}"
    cp -r "$src" /share/dokuwiki/plugins/
done

# Das Upgrade-Plugin abschalten: Es erneuert nur den Kern im Container, der beim nächsten Neustart wieder auf die
# Version des Images zurückfällt. DokuWiki-Updates kommen mit dem Add-on.
if [ ! -f /share/dokuwiki/conf/plugins.protected.php ]; then
    cat > /share/dokuwiki/conf/plugins.protected.php <<'PHP'
<?php
/*
 * Vom Add-on angelegt. DokuWiki wird über das Home-Assistant-Add-on aktualisiert; ein Upgrade im Wiki
 * ginge beim nächsten Neustart verloren und ließe Kern und Plugins auseinanderlaufen.
 */
$plugins['upgrade'] = 0;
PHP
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

# nginx braucht /run/nginx fuer die PID-Datei (wird im Container nicht automatisch angelegt)
mkdir -p /run/nginx

# PHP-FPM starten
php-fpm83 -D

# Nginx starten
exec nginx -g 'daemon off;'
