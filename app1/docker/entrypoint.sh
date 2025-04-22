#!/bin/bash

if [ ! -f "vendor/autoload.php" ]; then
    composer install --no-progress --no-interaction
fi

if [ ! -f ".env" ]; then
    echo "Creating env file for env $APP_ENV"
    cp .env.develop .env
else
    echo "env.develop file exists."
fi

php artisan horizon:install
php artisan migrate:fresh --seed
php artisan migrate:fresh --seed --seeder=UserSeeder
php artisan optimize
php artisan view:cache
php artisan serve --host=0.0.0.0 --port=9001 >> log.txt

php-fpm -D
nginx -g "daemon off;"
