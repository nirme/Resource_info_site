<?php defined('SYSPATH') or die('No direct script access.');

class Ajax_Controller extends My_Controller
{
	public function add_storage()
	{
		$this->mainView->setFilename('ajax');
		$this->view = new View('image');
		$ret = array('code' => 1);
		
		if (!isset($_POST['storage_name']) || empty($_POST['storage_name']))
		{
			$ret['code'] = 1;
			$this->view->data = json_encode($ret);
			return;
		}

		$name = $_POST['storage_name'];

		$resources = new Resources_Model;
		$res = $resources->findStorage($name);
		
		if ($res)
		{
			$ret['code'] = 0;
			$ret['existing'] = $res;
			$this->view->data = json_encode($ret);
			return;
		}

		$res = $resources->addStorage($name);
		$strg = $resources->getStorages();
		$ret['code'] = 0;
		$ret['id'] = $res;
		$ret['existing'] = 0;
		$ret['storages'] = $strg;
		$this->view->data = json_encode($ret);

	}


	public function add_company()
	{
		$this->mainView->setFilename('ajax');
		$this->view = new View('image');
		$ret = array('code' => 1);

		if (!isset($_POST['name_eng']) || !isset($_POST['name_jpn']) || (empty($_POST['name_eng']) && empty($_POST['name_jpn'])))
		{
			$ret['code'] = 1;
			$this->view->data = json_encode($ret);
			return;
		}

		$name_eng = $_POST['name_eng'];
		$name_jpn = $_POST['name_jpn'];

		$resources = new Resources_Model;
		$comp = $resources->getCompanys();

		$ret['existing'] = 0;
		foreach($comp as $c)
		{
			if ((!empty($name_eng) && (strcasecmp($name_eng, $c['name_eng']) == 0 || strcasecmp($name_eng, $c['name_jpn']) == 0)) || 
				(!empty($name_jpn) && (strcasecmp($name_jpn, $c['name_eng']) == 0 || strcasecmp($name_jpn, $c['name_jpn']) == 0)))
			{
				$ret['code'] = 0;
				$ret['existing'] = $c['id'];
				$this->view->data = json_encode($ret);
				return;
			}
		}

		$res = $resources->addCompany($name_eng, $name_jpn);
		$comp = $resources->getCompanys();
		$ret['code'] = 0;
		$ret['id'] = $res;
		$ret['existing'] = 0;
		$ret['companys'] = $comp;
		$this->view->data = json_encode($ret);

	}

	public function add_platform()
	{
		$this->mainView->setFilename('ajax');
		$this->view = new View('image');
		$ret = array('code' => 1);

		if (!isset($_POST['platformname']) || empty($_POST['platformname']))
		{
			$ret['code'] = 1;
			$this->view->data = json_encode($ret);
			return;
		}

		$name = $_POST['platformname'];

		$resources = new Resources_Model;
		$plat = $resources->getPlatforms();

		$ret['existing'] = 0;
		foreach($plat as $p)
		{
			if (strcasecmp($name, $p['name']) == 0)
			{
				$ret['code'] = 0;
				$ret['existing'] = $p['id'];
				$this->view->data = json_encode($ret);
				return;
			}
		}

		$res = $resources->addPlatform($name);
		$plat = $resources->getPlatforms();
		$ret['code'] = 0;
		$ret['id'] = $res;
		$ret['existing'] = 0;
		$ret['platforms'] = $plat;
		$this->view->data = json_encode($ret);

	}

	public function search_reference()
	{
		$this->mainView->setFilename('ajax');

		
		if (!isset($_POST['title']) || !isset($_POST['onList']))
		{
			$this->view = new View('image');
			$this->view->data = '0';
			return;
		}
		$title = $_POST['title'];
		$onList = $_POST['onList'];

		$resources = new Resources_Model;
		$reference = $resources->findByTitle($title, $onList);

		if (!$reference)
		{
			$this->view = new View('image');
			$this->view->data = '0';
			return;
		}

		$this->view = new View('search_reference');
		$this->view->reference = $reference;
	}
}
