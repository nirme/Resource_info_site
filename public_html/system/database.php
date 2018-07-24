<?php defined('SYSPATH') OR die('No direct access allowed.');


class Database
{
	// Database instances
	public static $instances = array();
	// Configuration
	protected $config = array
	(
		'connection'    => '',
		'character_set' => 'utf8'
	);

	protected $driver;
	protected $link;

	public static function & instance($name = 'default')
	{
		if ( ! isset(Database::$instances[$name]))
		{
			Database::$instances[$name] = new Database($name);
		}
		return Database::$instances[$name];
	}

	public static function instance_name(Database $db)
	{
		return array_search($db, Database::$instances, TRUE);
	}

	public function __construct($name = '')
	{
		$config = array();
		if(empty($name))
		{
			$config = Core::$config['database']['default'];
		}
		elseif (is_string($name))
		{
			if (!isset(Core::$config['database'][$name]))
				Core::show_404("Database doesn't exist.");

			$config = Core::$config['database'][$name];
		}

		$this->config = array_merge($this->config, $config);

		$this->driver = new MySQL_Driver($this->config);
	}

	public function connect()
	{
		if ( ! is_resource($this->link) && ! is_object($this->link))
		{
			$this->link = $this->driver->connect();
			if ( ! is_resource($this->link) && ! is_object($this->link))
				Core::show_404("Unable to connect to database");

			$this->config['connection']['pass'] = NULL;
		}
	}

	public function query($sql = '')
	{
		if ($sql == '') return FALSE;

		// No link? Connect!
		$this->link or $this->connect();

		if (func_num_args() > 1) //if we have more than one argument ($sql)
		{
			$argv = func_get_args();
			$binds = (is_array(next($argv))) ? current($argv) : array_slice($argv, 1);
		}

		// Compile binds if needed
		if (isset($binds))
		{
			$sql = $this->compile_binds($sql, $binds);
		}

		return $this->driver->query($sql);
	}

	public function compile_binds($sql, $binds)
	{
		foreach ((array) $binds as $val)
		{
			if (($next_bind_pos = strpos($sql, '?')) === FALSE)
				break;

			$val = $this->driver->escape($val);
			$val = str_replace('?', '{%B%}', $val);
			$sql = substr($sql, 0, $next_bind_pos).$val.substr($sql, $next_bind_pos + 1);
		}
		return str_replace('{%B%}', '?', $sql);
	}
}
