FROM php:5.6-apache

RUN a2enmod rewrite

# install the PHP extensions we need
RUN apt-get update && apt-get install -y libpng12-dev libjpeg-dev libpq-dev \
	&& rm -rf /var/lib/apt/lists/* \
	&& docker-php-ext-configure gd --with-png-dir=/usr --with-jpeg-dir=/usr \
	&& docker-php-ext-install gd mbstring pdo pdo_mysql pdo_pgsql zip

RUN mkdir /var/www/html/dtm

WORKDIR /var/www/html/dtm

RUN curl -fSL "https://github.com/indikagamage/dtm/archive/master.zip" -o dtm.zip \
	&& unzip dtm.zip -d /var/www/html/dtm/ \
	&& rm dtm.zip \
	&& chown -R www-data:www-data sites

