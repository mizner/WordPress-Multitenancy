<?php
/**
 * Plugin Name: Must Use Plugins Loader
 * Version: 1.0.0
 * License: GPL3+
 */

foreach (glob(dirname(__FILE__) . '/*', GLOB_ONLYDIR) as $dir) {
    $path = $dir . DIRECTORY_SEPARATOR . basename($dir) . '.php';
    if (!file_exists($path)) {
        continue;
    }
    require($dir . DIRECTORY_SEPARATOR . basename($dir) . '.php');
}
