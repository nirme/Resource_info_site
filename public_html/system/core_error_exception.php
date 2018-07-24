<?php	defined('SYSPATH') or die('No direct script access.');


class MyErrorException extends ErrorException
{
	protected $errorContext = array();

	public $errortype = array (
					E_ERROR              => 'Error',
					E_WARNING            => 'Warning',
					E_PARSE              => 'Parsing Error',
					E_NOTICE             => 'Notice',
					E_CORE_ERROR         => 'Core Error',
					E_CORE_WARNING       => 'Core Warning',
					E_COMPILE_ERROR      => 'Compile Error',
					E_COMPILE_WARNING    => 'Compile Warning',
					E_USER_ERROR         => 'User Error',
					E_USER_WARNING       => 'User Warning',
					E_USER_NOTICE        => 'User Notice',
					E_STRICT             => 'Runtime Notice',
					E_RECOVERABLE_ERROR  => 'Catchable Fatal Error'
	);

	public function __construct($code = 0, $message = '', $filename = '' , $lineno = 0, $errcontext = array())
	{
		$errorContext = $errcontext;
		parent::__construct($message, $code, 0, $filename, $lineno, NULL);
	}

	public final function getContext ()
	{
		return $this->errorContext;
	}

	public final function getErrName ()
	{
		return $this->errortype[$this->getCode()];
	}
}
