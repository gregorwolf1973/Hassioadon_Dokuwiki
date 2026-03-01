# DokuWiki Home Assistant Add-on

![DokuWiki Logo](https://www.dokuwiki.org/lib/tpl/dokuwiki/images/logo.png)

Ich habe kein für meine Zwecke brauchbares WIKI für Homeassistant gefunden, weshalb ich dieses erstellt habe. Probiert es gerne aus, wenn es euch hilft freue ich mich ;-)

## Über dieses Add-on

Dieses Add-on installiert [DokuWiki](https://www.dokuwiki.org) als Home Assistant Add-on. DokuWiki ist ein einfaches, aber mächtiges Wiki, das ohne Datenbank auskommt.

## Installation

[![Repository zu Home Assistant hinzufügen](https://my.home-assistant.io/badges/supervisor_add_addon_repository.svg)](https://my.home-assistant.io/redirect/supervisor_add_addon_repository/?repository_url=https%3A%2F%2Fgithub.com%2Fgregorwolf1973%2FHassioadon_Dokuwiki)

Oder manuell:
1. Füge dieses Repository in Home Assistant hinzu:
   - Einstellungen → Add-ons → Add-on Store → ⋮ → Repository hinzufügen
   - URL eingeben: `https://github.com/gregorwolf1973/Hassioadon_Dokuwiki`
2. Das Add-on **DokuWiki** suchen und installieren
3. Add-on starten
4. DokuWiki über `http://homeassistant.local:8080/install.php` einrichten

## Features

- DokuWiki ohne Datenbank
- Persistente Datenspeicherung in `/share/dokuwiki`
- Unterstützt `amd64` und `aarch64`
- Direkter Zugriff über Port 8080

## Datenspeicherung

Alle Wiki-Daten werden unter `/share/dokuwiki/` gespeichert und bleiben auch nach einer Deinstallation des Add-ons erhalten.

## Support

Bei Problemen bitte ein [Issue erstellen](https://github.com/gregorwolf1973/Hassioadon_Dokuwiki/issues).
