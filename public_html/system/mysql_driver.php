<?php defined('SYSPATH') OR die('No direct access allowed.');


class MySQL_Driver
{
	protected $link;
	protected $db_config;
	
	public function __construct($config)
	{
		$this->db_config = $config;
	}
	
	public function __destruct()
	{
		if (is_resource($this->link))
			mysql_close($this->link);
	}

	public function connect()
	{
		if (is_resource($this->link))
			return $this->link;

		extract($this->db_config['connection']);
		//user,pass,host,port,socket,database

		$host = isset($host) ? $host : $socket;
		$port = isset($port) ? ':'.$port : '';

		if (($this->link = mysql_connect($host.$port, $user, $pass, TRUE)) && mysql_select_db($database, $this->link))
		{
			if ($charset = $this->db_config['character_set'])
			{
				$this->set_charset($charset);
			}
			// Clear password after successful connect
			$this->db_config['connection']['pass'] = NULL;

			return $this->link;
		}

		return FALSE;
	}

	public function set_charset($charset)
	{
		$this->query('SET NAMES '.$this->escape_str($charset));
	}

	public function query($sql)
	{
		return new MySQL_Result(mysql_query($sql, $this->link), $this->link, $sql);
	}

	public function escape($value)
	{
		switch (gettype($value))
		{
			case 'string':
				$value = '\''.$this->escape_str($value).'\'';
			break;
			case 'boolean':
				$value = (int) $value;
			break;
			case 'double':
				$value = sprintf('%F', $value);
			break;
			default:
				$value = ($value === NULL) ? 'NULL' : $value;
			break;
		}

		return (string) $value;
	}

	public function escape_str($str)
	{
		is_resource($this->link) or $this->connect();
		return mysql_real_escape_string($str, $this->link);
	}
}

class MySQL_Result
{
	protected $return_type = MYSQL_ASSOC;
	protected $result = NULL;
	public $sql = 0;

	public $keys = FALSE;
	public $total_rows = 0;
	public $insert_id = 0;

	public function __construct($result, $link, $sql)
	{
		$this->result = $result;

		if (is_resource($result))
		{
			$this->total_rows  = mysql_num_rows($this->result);
		}
		elseif (is_bool($result) && $result != FALSE)
		{
			$this->insert_id  = mysql_insert_id($link);
			$this->total_rows = mysql_affected_rows($link);
		}

		$this->sql = $sql;
	}

	public function __destruct()
	{
		if (is_resource($this->result))
		{
			mysql_free_result($this->result);
		}
	}

	public function as_array()
	{
		return $this->result_array();
	}

	public function result_array()
	{
		$rows = array();

		if (!is_resource($this->result))
			return false;
		if (mysql_num_rows($this->result))
		{
			mysql_data_seek($this->result, 0);

			while ($row = mysql_fetch_array($this->result, $this->return_type))
			{
				$rows[] = $row;
			}
		}
		return $rows;
	}
	
	public function insert_id()
	{
		if ($this->insert_id != 0)
			return $this->insert_id;
		return FALSE;
	}

	public function list_fields()
	{
		if ($this->keys !== FALSE)
			return $this->keys;

		$this->keys = array();
		while ($field = mysql_fetch_field($this->result))
		{
			$this->keys[] = $field->name;
		}

		return $this->keys;
	}
}