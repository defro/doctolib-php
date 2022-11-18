###### Composer stage ######
FROM composer:latest as composer

COPY ./composer.json        /app/composer.json

WORKDIR /app

## Launch Composer installation
RUN composer install \
    --no-interaction \
    --ignore-platform-reqs \
    --no-plugins \
    --no-scripts \
    --prefer-dist

###### Final stage ######
FROM php:7.4-cli

COPY ./ /app

# Copy vendor from composer stage
COPY --from=composer /usr/bin/composer      /usr/bin/composer
COPY --from=composer /app/vendor            /app/

WORKDIR /app
