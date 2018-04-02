<?php
if (defined('WP_CLI') && WP_CLI) {
    define('DB_HOST', SL_DB_IP.':'.SL_DB_PORT); // Allows using WP CLI without having to SSH
} else {
    define('DB_HOST', 'localhost'); // https://github.com/wp-cli/wp-cli/issues/2431#issuecomment-178568416
}

define('DB_HOST', 'localhost');
define('DB_NAME', '@SITE_URL');
define('DB_USER', 'root');
define('DB_PASSWORD', 'root');
define('DB_CHARSET', 'utf8mb4');
define('DB_COLLATE', '');

define('AUTH_KEY', '.-sDA^xN>QXA+J&;S bR`3%;7)T+Dp,EU6vD2EcDlVE3NPf@@H*`{JkWt>~3Z82f');
define('SECURE_AUTH_KEY', 'bAr}qJc3lTQ)xSG&5glFY61^!ycL_$VPn1DPVa:><};).faY/7#,l5b-k>j$ih>1');
define('LOGGED_IN_KEY', 'h+zUb$H)e~[8t.;wC7Nfnc9I@S[f#~>z?F)+mo:a*l~Mo=T3Q[{{E~U^Ux*fW<#R');
define('NONCE_KEY', '({7ue,x]%0XZ7l5[I-W(Pe{1l4=,M5E8M=x{6OYwiG*hStx%j:KKE/o;E%x$&iJ!');
define('AUTH_SALT', '[xU+TpyR,o}up#F$0{}!?qq0&wKrXYlhU0qGx~]y(+~OnJ)]bwE7|Cac@0GK^1q+');
define('SECURE_AUTH_SALT', 'Vgh2X|/`_TdIqX=m6|1.q-jz`]e&^|YSP=S4OiZ=VIsbi+YESrs6,Vj^aZp32<}N');
define('LOGGED_IN_SALT', '+h*v6@Ec@b{UyI#$Xy.5T8a48a%wRR0pIPtH|?gY0LT=35Y*T--1M|^>N:PlS+ @');
define('NONCE_SALT', '=XFky[*a#>s$5-|-knh%i=f/G|TEE-zT8v:J#Fu?IB1gQG.;_G[zK4STvQ-N:h}W');

$table_prefix = 'wp_';

define('SL_THEME', 'genesis');
define('SL_CHILD_THEME', 'parallax-pro');

define('WP_DEBUG', true);
define('WP_DEBUG_LOG', true);
define('WP_DEBUG_DISPLAY', true);
define('JETPACK_DEV_DEBUG', true);