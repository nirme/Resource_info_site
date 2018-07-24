<?php defined('SYSPATH') or die('No direct script access.');

class Main_Controller extends My_Controller
{
	public $resPerPage = 30;

	public function index($page = 1, $type = FALSE, $search = FALSE)
	{
		$this->mainView->title = 'main';
		$this->view = new View('main');

		$resources = new Resources_Model;
		$this->view->page = $page;

		if (isset($_POST['res_type']) || isset($_POST['res_search']))
		{
			$type = 0;
			if (isset($_POST['res_type']))
			{
				if (count($_POST['res_type']) == 9 || count($_POST['res_type']) == 0)
					$type = 511;
				else
					foreach ($_POST['res_type'] as $rt)
						$type += pow(2,$rt - 1);
			}

			$search = !empty($_POST['res_search']) ? $_POST['res_search'] : FALSE;
			if (is_string($search))
				$searchUrl = urlencode($search);
		}
		else if (is_string($search))
		{
			$searchUrl = $search;
			$search = urldecode($search);
		}

		if (is_string($search))
		{
			$this->view->search = $search;
			$this->view->searchUrl = $searchUrl;
		}

		$type = intval($type);
		$this->view->type = $type;

		$restype = $resources->getResourceTypes();
		$this->view->restype = $restype;


		if ($type == 511 || $type == 0 || $type == FALSE)
			$type = FALSE;
		else
		{
			$typeq = array();
			foreach ($restype as $r)
				$typeq[$r['id']] = 0;

			$str = strrev(decbin($type));
			$type = array();
			$i=0;
			while (isset($str[$i]))
			{
				$typeq[$i+1] = intval($str[$i]);
				if (intval($str[$i]) == 1)
					$type[] = $i+1;
				$i++;
			}
			$this->view->typeq = $typeq;
		}

		$res = $resources->getResources($this->resPerPage, ($page - 1) * $this->resPerPage, $type, $search);
		$pages = $res['pages'];
		$res = $res['resources'];
		$this->view->pages = $pages;
		$this->view->resources = $res;

	}
}
