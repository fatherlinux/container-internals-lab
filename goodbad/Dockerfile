FROM registry.access.redhat.com/ubi7/php-72

MAINTAINER fatherlinux <scott.mccarty@gmail.com>

COPY ./docker-entrypoint.sh /entrypoint.sh
COPY ./index.php /var/www/html/index.php

ENTRYPOINT ["/entrypoint.sh"]
