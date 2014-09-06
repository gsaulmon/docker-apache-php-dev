FROM fedora

RUN yum update -y
RUN yum install -y php php-pdo php-mysql php-pgsql php-mbstring php-mcrypt php-pecl-xdebug psmisc sqlite

RUN echo -e '<VirtualHost *:80> \n DocumentRoot /var/www/html/public \n <Directory "/var/www/html/public"> \n AllowOverride All \n Require all granted \n </Directory> \n </VirtualHost>' > /etc/httpd/conf.d/vhost.conf
RUN echo 'date.timezone = "America/New_York"' > /etc/php.d/zz_timezone.ini

RUN echo zend_extension=/usr/lib64/php/modules/xdebug.so >> /etc/php.d/xdebug.ini;\
  echo xdebug.remote_enable=1 >> /etc/php.d/xdebug.ini;\
  echo xdebug.remote_autostart=0 >> /etc/php.d/xdebug.ini;\
  echo xdebug.remote_connect_back=1 >> /etc/php.d/xdebug.ini;\
  echo xdebug.remote_port=9000 >> /etc/php.d/xdebug.ini;

VOLUME  ["/var/www/html"]
EXPOSE 80

ENTRYPOINT ["httpd", "-D", "FOREGROUND"]