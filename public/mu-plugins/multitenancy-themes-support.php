<?php
/**
 * Plugin Name: WP Multitenancy Theme Support
 */

register_theme_directory(SL_THEME_PATH.'/candidate');

add_filter('theme_root', function () {
    return SL_THEME_PATH;
});

add_filter('theme_root_uri', function () {
    return SL_THEME_URI;
});