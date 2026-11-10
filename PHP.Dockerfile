FROM php:8.3-fpm

RUN apt-get update
RUN apt-get install -y zlib1g-dev libpng-dev libjpeg-dev libxml2-dev libzip-dev libxslt-dev libicu-dev libldap-dev locales

RUN docker-php-ext-configure gd --with-jpeg
RUN docker-php-ext-install gd
RUN docker-php-ext-install pdo
RUN docker-php-ext-install pdo_mysql
RUN docker-php-ext-install mysqli
RUN docker-php-ext-install soap
RUN docker-php-ext-install intl
RUN docker-php-ext-install zip
RUN docker-php-ext-install xsl
RUN docker-php-ext-install opcache
RUN docker-php-ext-install ldap

RUN pecl install xdebug
RUN pecl install -o -f redis &&  rm -rf /tmp/pear
RUN docker-php-ext-enable xdebug
RUN docker-php-ext-enable redis
RUN localedef -c -i en_AU -f UTF-8 en_AU.UTF-8

RUN mv "$PHP_INI_DIR/php.ini-development" "$PHP_INI_DIR/php.ini"

COPY ./moodlephp.ini "$PHP_INI_DIR/conf.d/moodlephp.ini"
COPY ./moodlephpfpm.conf "/usr/local/etc/php-fpm.d"
