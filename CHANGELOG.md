# Changelog

## 1.0.5

- DokuWiki 2024-02-06b → **2026-07-14c „Mort“**.
- Fix: Nach einem Upgrade über das Upgrade-Plugin im Wiki brach nach dem nächsten Add-on-Update jede Seite ab
  („Could not check compatibility … dokuwiki\Parsing\Handler is not available“ im Plugin `info`). Das Upgrade-Plugin
  erneuert den Kern nur im Container, die mitgelieferten Plugins aber dauerhaft unter `/share/dokuwiki` – nach dem
  Neustart passten beide nicht mehr zusammen.
- Beim Start gleicht das Add-on jetzt die mitgelieferten Plugins, das Standard-Template `dokuwiki` und die
  Standard-Konfigurationsdateien mit der DokuWiki-Version des Images ab. Eigene Einstellungen (`local.php`, ACL,
  Benutzer, `plugins.local.php`, `*.local.conf`), installierte Plugins und andere Templates bleiben unberührt.
  Anpassungen direkt im Template `dokuwiki` gehen dabei verloren – dafür `conf/userstyle.css` nutzen.
- Das Upgrade-Plugin wird über `conf/plugins.protected.php` abgeschaltet (nur wenn die Datei noch nicht existiert).
  DokuWiki-Updates kommen mit dem Add-on.

## 1.0.4

- PHP-Modul `php83-dom` ergänzt. Plugins wie BPMN.io (bpmnio) brauchen `DOMDocument`; ohne das Modul brach die Darstellung von Seiten mit BPMN-Diagrammen mit „Class "DOMDocument" not found“ ab.

## 1.0.3

- Fix: `armv7` aus `build.yaml` entfernt – die Architektur war in `config.yaml` `arch:` nicht gelistet (nur `aarch64`, `amd64`). build.yaml und config.yaml sind jetzt konsistent.

## 1.0.2

- Schlüssel `url` in der Add-on-Konfiguration ergänzt: Home Assistant zeigt auf der Add-on-Seite jetzt einen Link zum Repository. Sonst keine Änderungen am Image oder am Verhalten.

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
