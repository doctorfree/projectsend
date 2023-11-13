<?php
    global $oidc;

    $issuer = get_option('oidc_auth_url');
    $cid = get_option("openid_client_id");
    $secret = get_option("openid_client_secret");
    $oidc = new Jumbojett\OpenIDConnectClient($issuer, $cid, $secret);
?>
