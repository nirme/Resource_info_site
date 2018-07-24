<?php defined('SYSPATH') or die('No direct script access.');

class Image_Controller extends My_Controller
{

	public function index($id)
	{
		$this->mainView->setFilename('ajax');
		$this->view = new View('image');
		$resources = new Resources_Model;

		$img = $resources->getImage($id, FALSE);

		if ($img == FALSE)
		{
			header("HTTP/1.0 404 Not Found");
			return FALSE;
		}

		header("Content-Type: " . $img['mime_type']);
		$this->view->data = $img['file_data'];
	}

	public function thumb($id)
	{
		$this->mainView->setFilename('ajax');
		$this->view = new View('image');
		$resources = new Resources_Model;

		$img = $resources->getImage($id, TRUE);

		if ($img == FALSE)
		{
			header("HTTP/1.0 404 Not Found");
			return FALSE;
		}

		header("Content-Type: " . $img['mime_type']);
		$this->view->data = $img['file_data'];
	}
}
