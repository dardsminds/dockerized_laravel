# dockerized_laravel
A boilerplate for Laravel app in docker container

## Start docker container
Make sure your dockerdesktop is running and run the command below
docker compose up --build

## Generate SSL certificates
cd docker-compose/nginx/ssl/
openssl req -x509 -sha256 -nodes -days 365 -newkey rsa:2048 -keyout self-signed.key -out self-signed.crt


## Some issues and solitions

Error: Table 'laradock.sessions' doesn't exist

Solution:
php artisan make:session-table
php artisan migrate

------------------------------------------
Error:
SQLSTATE[HY000] [2002] No such file or directory (Connection: mysql, SQL: select * from `sessions` where `id` =

Solution:
set in  .env file
SESSION_DRIVER=file

