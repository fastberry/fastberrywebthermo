# start from the resin rpi-raspbian image
FROM fastberry/apachephpmysqlbase:latest
MAINTAINER fastberrypi@gmail.com

# we want nano to be present so we can edit config files, and of course
# we need python3

RUN apt-get -y update && apt-get -y install \
    nano \
    python3

COPY src/index.html /var/www/html/index.html
COPY src/index.php /var/www/html/index.php
COPY src/mysqltest.php /var/www/html/mysqltest.php
COPY src/webthermo.py /var/www/cgi/webthermo.py
COPY src/000-default.conf /etc/apache2/sites-enabled/000-default.conf

# copy the startup script for mysql
ADD src/start_mysql.sh /usr/bin/start_mysql.sh
ADD src/start_apache.sh /usr/bin/start_apache.sh
ADD src/start_lamp.sh /usr/bin/start_lamp.sh

# enable CGI
RUN sudo a2enmod mpm_prefork cgi

# start and run apache in the foregroundlamp
CMD ["/usr/bin/start_lamp.sh"]


