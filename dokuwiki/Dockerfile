ARG BUILD_FROM
FROM ${BUILD_FROM}

RUN apk add --no-cache \
    nginx \
    php83 \
    php83-fpm \
    php83-session \
    php83-gd \
    php83-xml \
    php83-dom \
    php83-mbstring \
    php83-openssl \
    php83-ctype \
    php83-zip \
    php83-fileinfo \
    wget

# DokuWiki-Version: Mitgelieferte Plugins, Standard-Template und Standard-Konfiguration gleicht run.sh bei jedem Start
# mit dieser Version ab, damit sie zum Kern passen.
ARG DOKUWIKI_VERSION=2026-07-14c

RUN wget -q https://github.com/dokuwiki/dokuwiki/releases/download/release-${DOKUWIKI_VERSION}/dokuwiki-${DOKUWIKI_VERSION}.tgz -O /tmp/dokuwiki.tgz \
    && mkdir -p /var/www/dokuwiki \
    && tar -xzf /tmp/dokuwiki.tgz -C /var/www/dokuwiki --strip-components=1 \
    && rm /tmp/dokuwiki.tgz \
    && cp -r /var/www/dokuwiki /var/www/dokuwiki.dist \
    && chown -R nobody:nobody /var/www/dokuwiki

COPY nginx.conf /etc/nginx/nginx.conf
COPY run.sh /run.sh
RUN chmod +x /run.sh

CMD [ "/run.sh" ]
