<?php

ini_set('error_reporting',E_ALL^E_NOTICE); 
ini_set('display_errors', FALSE);
ini_set('log_errors', FALSE);
$pathinfo = pathinfo(__FILE__);
define('MAIN_PATH',  $pathinfo['basename']);


define('DOCPATH', '/my_desk/public_html');
define('DOCROOT', $_SERVER['DOCUMENT_ROOT'] . '/my_desk/public_html');
define('APPPATH', DOCROOT . '/application');
define('SYSPATH', DOCROOT . '/system');
define('MODPATH', DOCROOT . '/modules');

require_once(SYSPATH . '/' . 'system.php');
