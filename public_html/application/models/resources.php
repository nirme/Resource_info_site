<?php defined('SYSPATH') or die('No direct script access.');

class Resources_Model extends Model
{
	public function getResources($limit = FALSE, $from = 0, $type = 0, $search = FALSE, $getPages = TRUE)
	{
		$data = array();
		$typeq = '';
		$lmt = '';

		if (is_array($type))
		{
			foreach ($type as &$t)
			{
				$data[] = $t;
				$t = 'resource_type = ?';
			}
			$typeq = ' WHERE (' . implode(' OR ', $type);
		}

		if ($search)
		{
			$data[] = '%' . $search . '%';
			$data[] = '%' . $search . '%';
			$data[] = '%' . $search . '%';
			$typeq .= (empty($typeq) ? ' WHERE (' : ') AND (') .'title LIKE ? OR title_romaji LIKE ? OR title_english LIKE ? ';
		}

		if (!empty($typeq))
			$typeq .= ')';

		if (is_int($limit))
		{
			$data[] = $from;
			$data[] = $limit;
			$lmt = ' LIMIT ?, ? ';
		}

		$sql = "SELECT resources.*, storage.name AS 'storage_name' FROM resources JOIN storage ON resources.storage_id = storage.id " . $typeq . " ORDER BY id DESC " . $lmt;
		$res = $this->db->query($sql, $data)->result_array();
		//$res = $this->db->query($sql, $data);
		//echo $res->sql;

		if ($getPages)
		{
			$sql = "SELECT COUNT(*) AS pages FROM resources " . $typeq;
			$pages = $this->db->query($sql, $data)->result_array();
			$pages = intval($pages[0]['pages'] / $limit) + ($pages[0]['pages'] % $limit ? 1 : 0);
			$res = array('pages' => $pages, 'resources' =>$res);
		}
		return $res;
	}

	public function getResourcesByType($type = 0, $limit = FALSE, $from = 0, $getPages = TRUE)
	{
		foreach ($type as &$t)
		{
			$t = 'resource_type = ' . $t;
		}
		$type = implode(' OR ', $type);

		$l = is_int($limit) ? ('LIMIT '. $from . ',' . $limit) : '';
		$sql = "SELECT resources.*, storage.name AS 'storage_name' FROM resources JOIN storage ON resources.storage_id = storage.id WHERE " . $type . " " . $l;
		$res = $this->db->query($sql)->result_array();

		if ($getPages)
		{
			$sql = "SELECT COUNT(*) AS pages FROM resources ";
			$pages = $this->db->query($sql)->result_array();
			$pages = intval($pages[0]['pages'] / $limit) + ($pages[0]['pages'] % $limit ? 1 : 0);
			$res = array('pages' => $pages, 'resources' =>$res);
		}
		return $res;

	}
	
	public function getResourceTypes()
	{
		$sql = "SELECT id, name FROM resource_type";
		return $this->db->query($sql)->result_array();
	}

	public function getCompanys()
	{
		$sql = "SELECT * FROM company ORDER BY name_eng ASC";
		return $this->db->query($sql)->result_array();
	}
	
	public function addCompany($name_eng, $name_jpn)
	{
		$sql = "INSERT INTO company (name_eng, name_jpn) VALUES (?,?) ";
		return $this->db->query($sql, $name_eng, $name_jpn)->insert_id();
	}

	public function getPlatforms()
	{
		$sql = "SELECT * FROM platform";
		return $this->db->query($sql)->result_array();
	}

	public function addPlatform($name)
	{
		$sql = "INSERT INTO platform (name) VALUES (?)";
		return $this->db->query($sql, $name)->insert_id();
	}

	public function getStorages()
	{
		$sql = "SELECT * FROM storage ORDER BY `name` DESC";
		return $this->db->query($sql)->result_array();
	}

	public function findStorage($name)
	{
		$sql = "SELECT id FROM storage WHERE name LIKE ? ";
		$res = $this->db->query($sql, $name)->result_array();
		if (empty($res))
			return FALSE;
		return $res[0]['id'];
	}

	public function addStorage($name)
	{
		$sql = "INSERT INTO storage (name) VALUES (?) ";
		return $this->db->query($sql, $name)->insert_id();
	}

	public function insertResource($resource_type, $title, $title_romaji, $title_english, $storage_id, $directory, $info, $files = array())
	{
		$title = $title;
		$title_romaji = $title_romaji;
		$title_english = $title_english;
		$directory = $directory;
		
/*		$search = array($title, $title, $title);

		$sql = "SELECT id FROM resources WHERE title LIKE ? OR title_romaji LIKE ? OR title_english LIKE ? ";
		if (!empty($title_romaji))
		{
			$sql .= "OR title LIKE ? OR title_romaji LIKE ? OR title_english LIKE ? ";
			$search[] = $title_romaji;
			$search[] = $title_romaji;
			$search[] = $title_romaji;
		}
		if (!empty($title_english))
		{
			$sql .= "OR title LIKE ? OR title_romaji LIKE ? OR title_english LIKE ? ";
			$search[] = $title_english;
			$search[] = $title_english;
			$search[] = $title_english;
		}

		$res = $this->db->query($sql, $search)->result_array(FALSE);
		if (!empty($res))
			return array('msg' => ('Resource by title: "' . $title . '" already exist.'), 'existing_id' => $res[0]['id']);
*/

		$sql = "INSERT INTO resources ( resource_type, title, title_romaji, title_english, storage_id, directory ) VALUES (?,?,?,?,?,?)";
		$res_id = $this->db->query($sql, intval($resource_type), $title, $title_romaji, $title_english, intval($storage_id), $directory)->insert_id();

		$sql = "SELECT * FROM resource_type WHERE id = ?";
		$res = $this->db->query($sql, $resource_type)->result_array();
		$table = $res[0]['table_name'];

		$keys = array('res_id');
		$vals = array($res_id);
		$ps = array('?');
		
		foreach ($info as $key => $val)
		{
			if (substr($key, 0, strpos($key, '-')) == $table)
			{
				$keys[] = substr($key, strpos($key, '-') + 1);
				$vals[] = $val;
				$ps[] = '?';
			}
		}

		$sql = "INSERT INTO " . $table . " ( " . implode(',', $keys) . " ) VALUES (" . implode(',', $ps) . ")";
		$this->db->query($sql,$vals);
		
		if (isset($info['reference-res_id2']) && !empty($info['reference-res_id2']))
		{
			$sql = "INSERT INTO reference ( res_id1,res_id2 ) VALUES ( ?, ? ), ( ?, ? ) ";
			foreach ($info['reference-res_id2'] as $val)
				$this->db->query($sql, $res_id, intval($val), intval($val), $res_id);
		}

		if (isset($info['info-text_data']) && !empty($info['info-text_data']))
		{
			$sql = "INSERT INTO info ( res_id, text_data ) VALUES ( ?, ? )";
			$this->db->query($sql, $res_id, $info['info-text_data']);
		}

		if (!empty($files))
		{
			if (isset($files['thumb-thumb']) && !empty($files['thumb-thumb']['name']))
			{
				$sql = "INSERT INTO thumb ( res_id, mime_type, file_size, file_data ) VALUES (?,?,?,?)";
				$this->db->query($sql, $res_id, $files['thumb-thumb']['type'], $files['thumb-thumb']['size'], file_get_contents($files['thumb-thumb']['tmp_name']));
			}

			if (isset($files['image-image']))
			{
				$sql = "INSERT INTO image ( res_id, filename, mime_type, file_size, file_data ) VALUES (?,?,?,?,?)";
				$i = 0;
				while (isset($files['image-image']['name'][$i]))
				{
					if (!empty($files['image-image']['name'][$i]))
						$this->db->query($sql, $res_id, 
										$files['image-image']['name'][$i], 
										$files['image-image']['type'][$i], 
										$files['image-image']['size'][$i], 
										file_get_contents($files['image-image']['tmp_name'][$i]));
					$i++;
				}
			}
		}

		return $res_id;
	}
	
	public function getResource($id, $getImages = TRUE)
	{
		$sql = "SELECT resources.*, storage.name AS 'storage', resource_type.name AS 'resource_name', resource_type.table_name AS 'resource_table'
				FROM resources JOIN storage ON resources.storage_id = storage.id 
				JOIN resource_type ON resources.resource_type = resource_type.id 
				WHERE resources.id = ? ";
		$res = $this->db->query($sql, $id)->result_array();
		$res = $res[0];

		$sql = "SELECT * FROM " . $res['resource_table'] . " WHERE res_id = ? ";
		$ri = $this->db->query($sql, $id)->result_array();
		$ri = $ri[0];

		if ($res['resource_type'] == 3)
		{
			$sql = "SELECT name AS 'platform' FROM platform WHERE id = ?";
			$pl = $this->db->query($sql, $ri['platform_id'])->result_array();
			$pl = $pl[0];
			$company_id = intval($ri['company_id']);
			if (is_int($company_id) && $company_id != 0)
			{
				$sql = "SELECT name_eng AS 'company_eng', name_jpn AS 'company_jpn' FROM company WHERE id = ?";
				$co = $this->db->query($sql, $company_id)->result_array();
				$pl = array_merge($pl, $co[0]);
			}
			else
			{
				$pl['company_eng'] = 'unknown';
				$pl['company_jpn'] = '';
			}
				
			$ri = array_merge($ri, $pl);
		}

		if ($getImages)
		{
			$sql = "SELECT res_id AS id, CONCAT('thumb_',res_id) AS 'filename' FROM thumb WHERE res_id = ? ";
			$th = $this->db->query($sql, $id)->result_array();
			$res['thumb'] = !empty($th) ? $th[0]: $res['thumb'] = false;

			$sql = "SELECT id, filename FROM image WHERE res_id = ? ";
			$im = $this->db->query($sql, $id)->result_array();
			$res['images'] = $im;
		}
		
		$sql = "SELECT text_data FROM info WHERE res_id = ? ";
		$te = $this->db->query($sql, $id)->result_array();
		if (isset($te[0]))
			$te = $te[0];

		$sql = "SELECT resources.id, title, title_romaji, title_english, resources.resource_type, resource_type.name AS 'resource_name' 
				FROM reference JOIN resources ON reference.res_id2 = resources.id 
				JOIN resource_type ON resources.resource_type = resource_type.id 
				WHERE reference.res_id1 = ? ";
		$rf = $this->db->query($sql, $id)->result_array();

		$res = array_merge($res, $ri, $te);
		$res['references'] = $rf;

		return $res;
	}

	public function getImage($id, $thumb = FALSE)
	{
		$table = 'image';
		$imgId = 'id';
		if ($thumb)
		{
			$table = 'thumb';
			$imgId = 'res_id';
		}

		$sql = "SELECT * FROM " . $table . " WHERE " . $imgId . " = ? ";
		$res = $this->db->query($sql, $id)->result_array();
		if (!empty($res))
			return $res[0];
		return FALSE;
	}

	public function findByTitle($title, $drop)
	{
		
		$sql = "SELECT * FROM resources 
				WHERE ( title LIKE ? OR title_romaji LIKE ? OR title_english LIKE ? ) " . 
				((!empty($drop)) ? " AND id NOT IN (" . $drop . ")" : "" ) . 
				"ORDER BY title ";
		$title = '%' . $title . '%';
		$res = $this->db->query($sql, $title, $title, $title)->result_array();
		if (!empty($res))
			return $res;
		return FALSE;
	}

	public function resourceExist($id)
	{
		$sql = "SELECT COUNT(*) AS num FROM resources WHERE id = ? ";
		$c = $this->db->query($sql, $id)->result_array();
		if ($c[0]['num'] > 0)
			return true;
		return false;
	}

}
