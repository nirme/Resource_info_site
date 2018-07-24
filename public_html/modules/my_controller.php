<?php defined('SYSPATH') or die('No direct script access.');

class My_Controller extends Controller
{
	public $mainView = 'mainframe';

	public function __construct()
	{
		$this->mainView = new View($this->mainView);
		parent::__construct();
	}

	public function __destruct()
	{
		$this->mainView->top_image = $this->findPictures(array('docroot' => DOCROOT, 'path' => '/files/top'));
		//$this->mainView->bg_image = $this->findPictures(array('docroot' => DOCROOT, 'path' => '/files/bg'));

		$this->view->docpath = DOCPATH;
		$content = $this->view->render(FALSE);
		$this->mainView->content = $content;
		$this->mainView->render(TRUE);
	}
	
	private function findPictures($directory, $arr = FALSE)
	{
		$path = '';
		if (is_array($directory))
		{
			$path = $directory['path'] . '/';
			$directory = $directory['docroot'] . $directory['path'];
		}
		$res = opendir($directory);
		$files = array();
		$img_ext = array('jpg', 'JPG', 'jpeg', 'JPEG', 'png', 'PNG', 'gif', 'GIF');
		while (($str = readdir($res)) !== FALSE)
			if ( strrpos($str, '.') !== FALSE && in_array(substr($str, strrpos($str, '.') + 1), $img_ext))
				$files[] = $path . $str;

		closedir($res);

		if ($arr)
			return $files;

		return $files[mt_rand(0,20*(count($files) - 1)) % count($files)];
	}
}
