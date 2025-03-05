FROM php:8.2-fpm-alpine

ARG user
ARG uid

RUN apk update && apk add \
    curl \
    libpng-dev \
    libxml2-dev \
    zip \
    unzip \
    shadow  # Add shadow package to install useradd

RUN docker-php-ext-install pdo pdo_mysql mysqli \
    && apk --no-cache add nodejs npm

COPY --from=composer:latest /usr/bin/composer /usr/local/bin/composer


USER root
#RUN chmod 777 -R /var/www/

RUN useradd -G www-data,root -u $uid -d /home/$user $user
RUN mkdir -p /home/$user/.composer && \
    chown -R $user:$user /home/$user

# Install Gulp for SASS
RUN npm install -g gulp 
# RUN npm install -g gulp-cli 
# RUN npm init -y
# RUN npm install --save-dev autoprefixer browser-sync css-mqpacker cssnano gulp-concat gulp-deporder gulp-imagemin gulp-newer gulp-postcss gulp-sass gulp-clean-css gulp-strip-debug gulp-uglify gulp-noop postcss-assets
RUN npm install --save-dev gulp-sass gulp-sourcemaps gulp-cssmin


WORKDIR /var/www
USER $user
