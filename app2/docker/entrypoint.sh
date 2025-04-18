#!/bin/bash

if [ ! -f "vendor/autoload.php" ]; then
    composer install --no-progress --no-interaction
fi

if [ ! -f ".env" ]; then
    echo "Creating env file for env $APP_ENV"
    cp .env.example .env
else
    echo "env file exists."
fi

composer require laravel/horizon
php artisan horizon:install
php artisan migrate
php artisan migrate --seed
php artisan optimize
php artisan view:cache

php-fpm -D
nginx -g "daemon off;"
