
FROM php:7.2-apache

# PHP extensions Install pdo_mysql
RUN docker-php-ext-install pdo pdo_mysql 

#Resolve the PDO issue
#COPY php.ini /usr/local/etc/php 
#RUN service apache2 restart

COPY src/ /var/www/html
EXPOSE 80
