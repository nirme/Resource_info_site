<?php defined('SYSPATH') or die('No direct script access.');

class Edit_Controller extends My_Controller
{
	public function index($id)
	{
		$resources = new Resources_Model;
		if (!$resources->resourceExist($id ))
		{
			$this->view = new View('404');
			return;
		}

		$this->view = new View('edit');

		$res = $resources->getResource($id);

		$storages = $resources->getStorages();
		$this->view->storages = $storages;

		$this->mainView->title = 'Edit resource';
		foreach ($res as $key => $val)
		{
			$this->view->$key = $val;
		}


/*
{$form_token}
*/

/*res_title
{$title}
{$title_romaji}
{$title_english}
*/

/*res_storage
{$storages}
{$storage_id}
{$directory}
*/
	}
}
