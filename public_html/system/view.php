<?php	defined('SYSPATH') or die('No direct script access.');

class View
{
	public $filename;
	public $ext;
	public $variables = array();
	
	public function __construct($name = NULL, $type = NULL)
	{
		if (is_string($name) AND $name !== '')
		{
			$this->setFilename($name, $type);
		}
	}
	
	public function setFilename($name, $type = NULL)
	{
		if (is_string($type) AND $type !== '')
		{
			$this->ext = $type;
		}
		else
		{
			$type = 'tpl';
		}
		
		$this->filename = $name;
	}
	
	public function render($print = TRUE)
	{
		if (!empty($this->filename) && file_exists($file = (APPPATH . '/views/' . $this->filename . '.tpl')))
		{
			$content = Core::$instance->load_view($file, $this->variables);

			if ($print)
			{
				echo $content;
				return;
			}
		}
		else
		{
			Core::show_404('view file: ' . $this->filename . ".tpl doesn't exist");
		}
		
		return $content;
	}
	
	
	public function __set($key, $value)
	{
		$this->variables[$key] = $value;
	}

	public function &__get($key)
	{
		if (isset($this->variables[$key]))
			return $this->variables[$key];

		if (isset($this->$key))
			return $this->$key;
	}
	
}
