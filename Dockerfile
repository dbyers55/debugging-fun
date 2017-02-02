#use the official PHP7 image with apache
FROM php:7.0-apache

#install wget which is required to download xdebug
RUN apt-get update && apt-get install -y wget

# install xdebug and enable it. This block of code goes through the installion from source and compiling steps found
# on the xdebug website
# https://xdebug.org/docs/install
RUN cd /tmp \
    && wget https://xdebug.org/files/xdebug-2.5.0.tgz \
    && tar -zxvf xdebug-2.5.0.tgz \
    && cd xdebug-2.5.0 \
    && /usr/local/bin/phpize \
    && ./configure --enable-xdebug --with-php-config=/usr/local/bin/php-config \
    && make \
    && cp modules/xdebug.so /usr/local/lib/php/extensions/no-debug-non-zts-20151012/


# add xdebug configurations
RUN { \
        echo '[xdebug]'; \
        echo 'zend_extension=/usr/local/lib/php/extensions/no-debug-non-zts-20151012/xdebug.so'; \
        echo 'xdebug.remote_enable=on'; \
        echo 'xdebug.remote_autostart=on'; \
        echo 'xdebug.remote_connect_back=off'; \
        echo 'xdebug.remote_handler=dbgp'; \
        echo 'xdebug.profiler_enable=off'; \
        echo 'xdebug.profiler_output_dir="/var/www/html"'; \
        echo 'xdebug.remote_port=9001'; \
        echo 'xdebug.remote_host=100.254.254.254'; \
    } > /usr/local/etc/php/conf.d/xdebug.ini

# add the application to the container outside of the web root
COPY app /app

# create a symlink to from the app to the web root
RUN mkdir -p /app && rm -fr /var/www/html && ln -s /app/web /var/www/html

