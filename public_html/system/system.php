<?php	defined('SYSPATH') or die('No direct script access.');


require_once('Smarty.class.php');

$handle = opendir(SYSPATH);
while(!(($file = readdir($handle)) === FALSE)) { if (is_file(SYSPATH . '/' . $file)) { require_once(SYSPATH . '/' . $file); } }
closedir($handle);

$handle = opendir(MODPATH);
while(!(($file = readdir($handle)) === FALSE)) { if (is_file(MODPATH . '/' . $file)) { require_once(MODPATH . '/' . $file); } }
closedir($handle);

Core::setup();
Core::instance();