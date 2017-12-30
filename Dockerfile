FROM php:5.6-fpm-alpine

RUN apk update \
    && apk add --no-cache libxml2-dev libjpeg-turbo-dev zlib-dev libpng-dev \
        libmcrypt-dev openssl-dev curl-dev libxslt-dev sqlite-dev autoconf gcc g++ make \
    && docker-php-ext-install mysqli \
                              pdo_mysql \
                              gd \
                              zip \
                              xsl \
                              soap \
			      sockets \ 
			      mcrypt \
	        && apk del libxml2-dev libjpeg-turbo-dev zlib-dev libpng-dev \
        libmcrypt-dev openssl-dev curl-dev libxslt-dev sqlite-dev autoconf \
	gcc g++ libc-dev make \
    && apk add nginx supervisor libxslt libmcrypt libpng \
    && mkdir /app /logs /run/nginx

# For PHP 7 add the following lines
# FROM php:fpm-alpine
# && pecl install mcrypt-1.0.1 \
# && docker-php-ext-enable mcrypt \



COPY supervisord.conf /etc/supervisord.conf
COPY nginx.conf /etc/nginx/nginx.conf

WORKDIR /app

RUN apk add git \
    && git clone https://github.com/phpservermon/phpservermon.git ./ \
    && php composer.phar install \
    && rm -rf Makefile Vagrantfile composer* .git \
    && apk del git

COPY update_status.sh /usr/local/bin/update_status.sh
COPY start.sh /usr/local/bin/start.sh

RUN chmod +x /usr/local/bin/update_status.sh
RUN chmod +x /usr/local/bin/start.sh

CMD ["/usr/local/bin/start.sh"]

EXPOSE 80
