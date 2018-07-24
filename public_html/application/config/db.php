<?php defined('SYSPATH') OR die('No direct access allowed.');

$config['default'] = array
(
	'connection'    => array
	(
		'type'     => 'mariadb',
		'user'     => 'amg_server',
		'pass'     => 'amg_server',
		'host'     => 'localhost',
		'port'     => FALSE,
		'socket'   => FALSE,
		'database' => 'amg'
	),
	'character_set' => 'utf8',
	'object'        => TRUE,
);
