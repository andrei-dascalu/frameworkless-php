#!/bin/sh

COMPOSER_VERSION="2.5.8"

curl -s -f -L -o /tmp/installer.php https://getcomposer.org/installer \
&& php /tmp/installer.php --no-ansi --install-dir=/usr/local/bin --filename=composer --version=${COMPOSER_VERSION} \
&& rm -rf /tmp/installer.php \
