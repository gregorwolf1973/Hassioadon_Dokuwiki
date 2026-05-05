ARG BUILD_FROM
FROM ${BUILD_FROM}

# 1. Install Nginx and PHP 8.3 with all necessary extensions
RUN apk add --no-cache \
    nginx \
    php83 \
    php83-fpm \
    php83-session \
    php83-json \
    php83-gd \
    php83-xml \
    php83-dom \
    php83-simplexml \
    php83-mbstring \
    php83-openssl \
    php83-ctype \
    php83-zip \
    php83-fileinfo \
    php83-curl \
    php83-iconv \
    php83-zlib \
    wget \
    tar \
    unzip

# 2. Redirect Nginx logs to stdout/stderr
# This ensures Nginx logs appear in the Home Assistant Add-on "Logs" tab
RUN ln -sf /dev/stdout /var/log/nginx/access.log && \
    ln -sf /dev/stderr /var/log/nginx/error.log

# 3. Download and extract DokuWiki
RUN wget -q https://download.dokuwiki.org/src/dokuwiki/dokuwiki-stable.tgz -O /tmp/dokuwiki.tgz \
    && mkdir -p /var/www/dokuwiki \
    && tar -xzf /tmp/dokuwiki.tgz -C /var/www/dokuwiki --strip-components=1 \
    && rm /tmp/dokuwiki.tgz \
    && cp -r /var/www/dokuwiki /var/www/dokuwiki.dist \
    && chown -R nobody:nobody /var/www/dokuwiki

# 4. Copy configuration and startup script
COPY nginx.conf /etc/nginx/nginx.conf
COPY run.sh /run.sh
RUN chmod +x /run.sh

CMD [ "/run.sh" ]
