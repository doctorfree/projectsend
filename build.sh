#!/bin/bash
#

export PATH="$PATH:/usr/local/bin"

have_php=$(type -p php)
[ "${have_php}" ] || {
  printf "\nERROR: php not found. Exiting.\n"
  exit 1
}
have_npm=$(type -p npm)
[ "${have_npm}" ] || {
  printf "\nERROR: npm not found. Exiting.\n"
  exit 1
}

have_gulp=$(type -p gulp)
[ "${have_gulp}" ] || sudo apt install gulp -q -y

have_comp=$(type -p composer)
[ "${have_comp}" ] || {
  curl -sS https://getcomposer.org/installer -o /tmp/composer-setup.php
  sudo php /tmp/composer-setup.php --install-dir=/usr/local/bin --filename=composer
}
have_comp=$(type -p composer)
[ "${have_comp}" ] || {
  printf "\nERROR: composer not found. Exiting.\n"
  exit 1
}

composer require jumbojett/openid-connect-php

npm install
composer update
gulp
