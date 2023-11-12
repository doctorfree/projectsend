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
if [ -f okta/oauth ]; then
  source okta/oauth
  sudo sed -i -e "s/__CLIENT_ID__/${SEND_CLIENT_ID}/" \
              -e "s/__CLIENT_SECRET__/${SEND_CLIENT_SECRET}/" \
              -e "s/__OIDC_ISSUER_URL__/${SEND_ISSUER_URL}/" \
           login-openid.php
else
  printf "\nWARNING: Missing okta/oauth credentials file"
  printf "\n\tProjectSend not configured for OpenID OAuth\n"
fi

find . -type d -print0 | xargs -0 sudo chmod 775
find . -type f -print0 | xargs -0 sudo chmod 644
sudo chown -R www-data:www-data .

npm install
composer update
gulp
