FROM php:7.4-apache as php-7-4-build

# Set some image labels
LABEL evilwizardcreations.image.authors="evil.wizard95@googlemail.com" \
    evilwizardcreations.image.php.version="7.4"

# copy the specific Composer PHAR version from the Composer image into the PHP image
COPY --from=composer:1.10.1 /usr/bin/composer /usr/bin/composer

# Download the nodejs setup & set that it's a docker env.
ENV NODE_ENV docker
RUN curl --silent --location https://deb.nodesource.com/setup_14.x | bash

# Enable some apache modules.
RUN a2enmod rewrite; \
    a2enmod headers; \
    a2enmod ssl

# Install some extra stuff
RUN set -ex; \
    apt-get update; \
    apt-get install -y --no-install-recommends \ 
      libxml2-dev \
      libzip-dev \
      libyaml-dev \
      zip \
      git \
      nodejs  \
      default-mysql-client \ 
      vim; \
    apt-get clean; \
    npm i npm@6.4.1 -g

# Install some php extensions from the docker built source.
RUN docker-php-ext-install gettext mysqli pdo_mysql zip
RUN pecl install yaml && \
    docker-php-ext-enable yaml
