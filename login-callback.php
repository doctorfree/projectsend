<?php
use ProjectSend\Classes\Session as Session;

require_once 'bootstrap.php';

global $hybridauth;
global $auth;
global $oidc;
$provider = Session::get('SOCIAL_LOGIN_NETWORK');
if ($provider == 'openid') {
  $oidc->authenticate();
  $auth->socialLogin($provider);
}
else {
  $adapter = $hybridauth->authenticate($provider);
  if ($adapter->isConnected($provider)) {
    $auth->socialLogin($provider);
  }
}
