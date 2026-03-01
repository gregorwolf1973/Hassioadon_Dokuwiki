ARG BUILD_FROM
FROM ${BUILD_FROM}

RUN apk add --no-cache \
    nginx \
    php83 \
    php83-fpm \
    php83-session \
    php83-json \
    php83-gd \
    php83-xml \
    php83-mbstring \
    php83-openssl \
    php83-ctype \
    php83-zip \
    php83-fileinfo \
    wget \
    unzip

RUN wget -q https://download.dokuwiki.org/src/dokuwiki/dokuwiki-stable.tgz -O /tmp/dokuwiki.tgz \
    && mkdir -p /var/www/dokuwiki \
    && tar -xzf /tmp/dokuwiki.tgz -C /var/www/dokuwiki --strip-components=1 \
    && rm /tmp/dokuwiki.tgz \
    && cp -r /var/www/dokuwiki /var/www/dokuwiki.dist \
    && chown -R nobody:nobody /var/www/dokuwiki

COPY nginx.conf /etc/nginx/nginx.conf
COPY run.sh /run.sh
RUN chmod +x /run.sh

CMD [ "/run.sh" ]
