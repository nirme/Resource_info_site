<?php	defined('SYSPATH') or die('No direct script access.');

class Core
{
	public static $instance;
	public static $current_uri;
	public static $routes = array();
	
	public static $controller;
	public static $controller_path;
	public static $method = 'index';
	public static $arguments = array();
	public static $config = 0;////////////////////////ADD DB INFOS
	
	private static function get_uri()
	{
		if (isset($_GET['uri']))
		{
			self::$current_uri = htmlspecialchars($_GET['uri'], ENT_QUOTES, 'UTF-8');
			unset($_GET['uri']);
			$_SERVER['QUERY_STRING'] = preg_replace('~\buri\b[^&]*+&?~', '', $_SERVER['QUERY_STRING']);
		}
		elseif (isset($_SERVER['PATH_INFO']) && $_SERVER['PATH_INFO'])
		{
			self::$current_uri = $_SERVER['PATH_INFO'];
		}
		elseif (isset($_SERVER['ORIG_PATH_INFO']) && $_SERVER['ORIG_PATH_INFO'])
		{
			self::$current_uri = $_SERVER['ORIG_PATH_INFO'];
		}
		elseif (isset($_SERVER['PHP_SELF']) && $_SERVER['PHP_SELF'])
		{
			self::$current_uri = $_SERVER['PHP_SELF'];
		}
		
		if (($strpos_fc = strpos(self::$current_uri, MAIN_PATH)) !== FALSE)
		{
			self::$current_uri = (string) substr(self::$current_uri, $strpos_fc + strlen(MAIN_PATH));
		}
		
		self::$current_uri = preg_replace('#//+#', '/', self::$current_uri);
		self::$current_uri = preg_replace('#\.[\s./]*/#', '', self::$current_uri);
		self::$current_uri = trim(self::$current_uri, '/');
		
		$default_route = FALSE;
		if (empty(self::$current_uri))
		{
			if (!isset(self::$routes['_default']))
			{
				Core::show_404('no_default_route');
			}
			self::$current_uri = self::$routes['_default'];
			$default_route = TRUE;
		}

		self::$arguments = explode('/', self::$current_uri);
		self::$controller = self::$arguments[0];
		self::$arguments = array_slice(self::$arguments, 1);

		if (is_file(APPPATH . '/' . 'controllers/' . self::$controller . '.php'))
		{
			self::$controller_path = APPPATH . '/' . 'controllers/' . self::$controller . '.php';
			if (isset(self::$arguments[0]))
			{
				self::$method = self::$arguments[0];
				self::$arguments = array_slice(self::$arguments, 1);
			}
			else
				self::$method = 'index';
		}

		if (self::$controller_path === NULL)
		{
			Core::show_404('controller file: ' . self::$controller . ".php doesn't exist!");
		}
	}

	private static function printr($data, $pre = '')
	{
		$tmp = '';
		if ($pre == '') { $tmp = $tmp . "<pre>\n"; }
		if (is_array($data))
		{
			foreach($data as $key => $val)
			{
				if (!is_array($val))
				{
					$tmp = $tmp . $pre . $key . ' => ' . $val . "\n";
				}
				else
				{
					$tmp = $tmp . $pre . $key . " => Array\n" . $pre . "{\n";
					$tmp = $tmp . self::printr($val, $pre . '   ');
					$tmp = $tmp . $pre . "}\n";
				}
			}
		}
		if ($pre == '') { $tmp = $tmp . '</pre>'; }
		return $tmp;
	}

	public static function setup()
	{
		//error_reporting(~E_NOTICE & ~E_STRICT);
		spl_autoload_register(array('Core', 'auto_load'));

		set_error_handler (array('Core', 'error_handler'));
		set_exception_handler(array('Core', 'exception_handler'));
		register_shutdown_function(array('Core', 'shutdown_handler'));

		Smarty::muteExpectedErrors();

		self::$instance = NULL;
		self::$current_uri = NULL;
		self::$controller = NULL;
		self::$routes['_default'] = 'main';
	}
	
	public static function & instance()
	{
		if (self::$instance === NULL)
		{
			require_once(APPPATH . '/' . 'config/db.php');
			self::$config = array();
			self::$config['database'] = array();
			foreach ($config as $key => $val)
				self::$config['database'][$key] = $val;

			if (!array_key_exists('default', self::$config['database']) && isset($config[0]))
				self::$config['database']['default'] = $config[0];

			self::$config['database']['default'];


			self::get_uri();

			require_once(self::$controller_path);
			
			try
			{
				// Start validation of the controller
				$class = new ReflectionClass(ucfirst(self::$controller).'_Controller');
			}
			catch (ReflectionException $e)
			{
				// Controller does not exist
				Core::show_404('Controller does not exist');
			}

			if ($class->isAbstract())
			{
				Core::show_404('controller is abstract');
			}
			
			$ctr = $class->newInstance();

			try
			{
				$met = $class->getMethod(self::$method);
				if ($met->isProtected() or $met->isPrivate())
				{
					throw new ReflectionException('protected controller method');
				}
				$args = self::$arguments;
			}
			catch (ReflectionException $e)
			{
				//Core::goto_start();
				Core::show_404($e->getMessage());
			}

			// Execute the controller method
			$met->invokeArgs($ctr, $args);
		}

		return self::$instance;
	}
	
	public static function error_handler($errno, $errstr, $errfile, $errline, $errcontext)
	{
		$e = new MyErrorException($errno,$errstr,$errfile,$errline,$errcontext);
		self::exception_handler($e);
	}

	public static function exception_handler($exception)
	{
		$error = array();
		$error['msg'] = $exception->getMessage();
		$error['errno'] = $exception->getCode();
		$error['file'] = $exception->getFile();
		$error['line'] = $exception->getLine();
		$error['context'] = array();
		$error['errname'] = 'Exception';
		if (get_class($exception) == 'MyErrorException')
		{
			$error['context'] = $exception->getContext();
			$error['errname'] = $exception->getErrName();
		}
		self::showErrorPage($error);
		exit;
	}

	public static function shutdown_handler()
	{
		if ($error = error_get_last())
		{
			$e = new MyErrorException($error['type'],$error['message'],$error['file'],$error['line']);
			self::exception_handler($e);
		}
	}
	
	public static function showErrorPage($error)
	{
		$tmp = $error['errname'] . ' number: ' . $error['errno'] . ":<br>\n" . $error['msg'] . 
				' in file: ' . $error['file'] . '[' . $error['line'] . ']' . "<br>\n";

		if (!empty($error['context']))
			$tmp .= "<br>\n" . self::printr($error['context']);
		
		echo $tmp;
		exit;
	}

	public static function find_file($directory, $filename)
	{
		$file = APPPATH . '/' . $directory . '/' . $filename . '.php';
		if (file_exists($file))
		{
			return $file;
		}
		return FALSE;		
	}

	public static function auto_load($class)
	{
		if (class_exists($class, FALSE))
			return TRUE;

		if (($suffix = strrpos($class, '_')) > 0)
		{
			// Find the class suffix
			$suffix = substr($class, $suffix + 1);
		}
		else
		{
			return FALSE;
		}

		if ($suffix === 'Controller')
		{
			$type = 'controllers';
			$file = strtolower(substr($class, 0, -11));
		}
		elseif ($suffix === 'Model')
		{
			$type = 'models';
			$file = strtolower(substr($class, 0, -6));
		}
		elseif ($suffix === 'Module')
		{
			$type = 'modules';
			$file = strtolower(substr($class, 0, -7));
		}
		else
		{
			$type = 'system';
			$file = strtolower($class);
		}

		if ($filename = self::find_file($type, $file))
		{
			require $filename;
		}
		else
		{
			return FALSE;
		}

		return TRUE;
	}

	public static function show_404($str = '')
	{
		header("HTTP/1.0 404 Not Found");
		exit;

		if ($str)
			echo ' - ' . $str;
		exit;
	}
	
	public static function goto_start()
	{
		header('Location: ' . DOCPATH);
		exit;
	}
}
