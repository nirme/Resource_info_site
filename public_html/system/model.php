<?php defined('SYSPATH') OR die('No direct access allowed.');

class Model {

	protected $db = 'default';

	public function __construct()
	{
		if ( ! is_object($this->db))
		{
			$this->db = Database::instance($this->db);
		}
	}
}