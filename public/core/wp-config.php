<?php
define('SL_DB_IP', '192.168.33.44');
define('SL_DB_PORT', '3306');

define('SL_BUSINESS_TITLE', 'Simple Launch');
define('SL_BUSINESS_LINK', '//simplelaun.ch');

define('SL_SITE', $_SERVER['HTTP_HOST']);

define('SL_ROOT_PATH', $_SERVER['DOCUMENT_ROOT']);
define('SL_ROOT_URI', 'http://'.SL_SITE);

define('SL_THEME_URI', SL_ROOT_URI.'/themes');
define('SL_THEME_PATH', SL_ROOT_PATH.'/themes');

// load site-specific configurations.
require_once dirname(SL_ROOT_PATH).'/'.SL_SITE.'/wp-tenant-config.php';

define('WP_CONTENT_URL', SL_ROOT_URI.'/content');
define('WP_CONTENT_DIR', SL_ROOT_PATH.'/content');

defined('WP_SITEURL') || define('WP_SITEURL', SL_ROOT_URI.'/core');
defined('WP_HOME') || define('WP_HOME', SL_ROOT_URI);

define('WP_PLUGIN_URL', SL_ROOT_URI.'/plugins');
define('WP_PLUGIN_DIR', SL_ROOT_PATH.'/plugins');

define('WPMU_PLUGIN_URL', SL_ROOT_URI.'/mu-plugins');
define('WPMU_PLUGIN_DIR', SL_ROOT_PATH.'/mu-plugins');

define('WP_DEFAULT_THEME', 'genesis');

// Akismet, Jetpack
define('WPCOM_API_KEY', 'd0dbdc8cbbf4');
// Gravity Forms link: https://docs.gravityforms.com/wp-config-options/
define('GF_LICENSE_KEY', 'd5c2aba35ce2f6f9c6f92607f9415f4a');


/** Absolute path to the WordPress directory. */
if (!defined('ABSPATH')) {
    define('ABSPATH', dirname(__FILE__).'/core');
//	define( 'ABSPATH', dirname( __FILE__ ) );
}

/** Sets up WordPress vars and included files. */
require_once ABSPATH.'wp-settings.php';
