<?php	defined('SYSPATH') or die('No direct script access.');

abstract class Controller
{
	private $smarty;
	public $view;

	public function __construct()
	{
		Core::$instance = $this;
		$this->smarty = new Smarty();
		$this->smarty->template_dir = MODPATH . '/' . 'smarty/templates';
		$this->smarty->config_dir = MODPATH . '/' . 'smarty/config';
		$this->smarty->cache_dir = MODPATH . '/' . 'smarty/cache';
		$this->smarty->compile_dir = MODPATH . '/' . 'smarty/templates_c';
		session_start();

	}

	public function load_view($template, $variables)
	{
		if ($template == '')
			return;

		// Assign variables to the template
		if (is_array($variables) AND count($variables) > 0)
		{
			foreach ($variables AS $key => $val)
			{
				$this->smarty->assign($key, $val);
			}
		}

		//$this->smarty->assign('this', $this);
			// Fetch the output
		$output = $this->smarty->fetch($template);

		return $output;
	}
	
/*	public function __destruct()
	{
	}
*/

}
