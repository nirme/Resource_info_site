<?php defined('SYSPATH') or die('No direct script access.');

class AddEntry_Controller extends My_Controller
{

	public function index()
	{
		$this->mainView->title = 'Add entry';
		$this->view = new View('addEntry');
		$resources = new Resources_Model;

		if (isset($_POST['form_token']) && isset($_SESSION['form_token']) && $_POST['form_token'] == $_SESSION['form_token'])
		{
			unset($_SESSION['form_token']);

			if (!empty($_POST['galge-release_date']))
			{
				if ($_POST['galge-release_date'][0] == '[')
				{
					$date = array();
					$date[0] = intval(substr($_POST['galge-release_date'], 1, 2));
					$date[0] += ($date[0] < 80) ? 2000 : 1900;
					$date[1] = intval(substr($_POST['galge-release_date'], 3, 2));
					$date[2] = intval(substr($_POST['galge-release_date'], 5, 2));
				}
				else
				{
					$date = explode('-', $_POST['galge-release_date']);
					if (count($date) != 3)
						$date = explode('.', $_POST['galge-release_date']);
					foreach ($date as &$d)
						$d = intval($d);
				}

				if (count($date) != 3 || $date[1] > 12 || $date[1] < 1 || $date[2] > 31 || $date[2] < 1)
					$_POST['galge-release_date'] = NULL;
				else
					$_POST['galge-release_date'] = $date[0] . '-' . $date[1] . '-' . $date[2];
			}
			//add checks
			$id = $resources->insertResource($_POST['resource-resource_type'], $_POST['resource-title'], $_POST['resource-title_romaji'],
											$_POST['resource-title_english'], $_POST['resource-storage_id'], $_POST['resource-directory'], 
											$_POST, $_FILES);

			if (is_int($id))
			{
				$this->view->added = TRUE;
				$this->view->id = $id;
			}
			else
			{
				$this->view->added = FALSE;
				if (isset($id['msg']))
					$this->view->error = $id['msg'];
				if (isset($id['existing_id']))
					$this->view->existing_id = $id['existing_id'];
			}

			$this->view->title = $_POST['resource-title'];
			$this->view->title_ro = $_POST['resource-title_romaji'];
			$this->view->title_en = $_POST['resource-title_english'];

			return;
		}

		$company = $resources->getCompanys();
		$this->view->company = $company;

		$platform = $resources->getPlatforms();
		$this->view->platform = $platform;

		$storages = $resources->getStorages();
		$this->view->storages = $storages;

		$restype = $resources->getResourceTypes();
		$this->view->restype = $restype;

		$_SESSION['form_token'] = dechex(mt_rand(268435456,4294967295)) . dechex(mt_rand(268435456,4294967295));
		$this->view->form_token = $_SESSION['form_token'];
	}
}
