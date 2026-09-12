# Changelog

## 1.0.1

- Fix: `php83-json` aus dem Dockerfile entfernt – das Paket existiert in Alpine 3.20 nicht (JSON ist seit PHP 8 fest eingebaut), dadurch schlug der Image-Build fehl.
- Fix: nginx – Sperre für interne Verzeichnisse (`data`, `conf`, jetzt auch `bin`, `inc`, `vendor` sowie `.ht*`) steht nun vor den PHP-Locations; vorher wurden z.B. `/conf/*.php` von PHP-FPM ausgeführt statt blockiert.
- Fix: `/run/nginx` wird vor dem Start angelegt (PID-Verzeichnis von nginx unter Alpine).
- nginx-Fehler werden nach stderr geloggt und erscheinen damit im Add-on-Log.
- Basis-Image `ghcr.io/hassio-addons/base` 16.3.2 → 16.3.6 (Alpine 3.20).
- Nicht benötigtes Paket `unzip` entfernt.
- `.gitattributes`: Shell-Skripte werden immer mit LF-Zeilenenden ausgecheckt.

## 1.0.0

- Erste Version: DokuWiki 2024-02-06b mit nginx + PHP 8.3 FPM, persistente Daten unter `/share/dokuwiki`.
