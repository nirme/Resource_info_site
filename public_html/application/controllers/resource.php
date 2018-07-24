<?php defined('SYSPATH') or die('No direct script access.');

class Resource_Controller extends My_Controller
{
	public function index($id)
	{
		$resources = new Resources_Model;
		if (!$resources->resourceExist($id ))
		{
			$this->view = new View('404');
			return;
		}

		$this->view = new View('resource');

		$res = $resources->getResource($id);
		$this->mainView->title = $res['title'];
		
		$this->mainView->edit_resource = true;
		$this->mainView->res_id = $id;

		foreach ($res as $key => $val)
		{
			$this->view->$key = $val;
		}
	}
}
