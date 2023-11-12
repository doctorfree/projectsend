<?php
use ProjectSend\Classes\Session as Session;

require_once 'bootstrap.php';
require 'vendor/autoload.php';

$issuer = '__OIDC_ISSUER_URL__';
$cid = '__CLIENT_ID__';
$secret = '__CLIENT_SECRET__';
$oidc = new Jumbojett\OpenIDConnectClient($issuer, $cid, $secret);

$oidc->authenticate();
$oidc->requestUserInfo('sub');

$session = array();
foreach($oidc as $key=> $value) {
    if(is_array($value)){
            $v = implode(', ', $value);
    }else{
            $v = $value;
    }
    $session[$key] = $v;
}

session_start();
$_SESSION['attributes'] = $session;

header("Location: ./attributes.php");

?>
