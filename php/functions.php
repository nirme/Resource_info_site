<?php

function DBconnect()
{
	$database = new mysqli($GLOBALS['DBhost'], $GLOBALS['DBuser'], $GLOBALS['DBpass'], $GLOBALS['DBname'], $GLOBALS['DBport']);
	if (mysqli_connect_errno())
		{	return false;	}
	return $database;
}

function page($pageIn)
{
if ($GLOBALS['page_array'][$pageIn])
	{	return $GLOBALS['page_array'][$pageIn];	}
return array('error - page not found', 'pages/error_pnf.php');
}

function login($login, $pass)
{
	if (empty($login) || empty($pass))
		{	return "user don't exist";	}
	if (!$database = DBconnect())
		{	return "DB error - cannot connect";	}
	$result = $database->query("select id from users where login = '".addslashes($login)."' and pass = sha1('".addslashes($password)."');");
	if (!$result)
		{	return "DB error - query cannot be executed";	}
	if ($result->num_rows == 0)
		{	return "user don't exist";	}
	$row = $result->fetch_assoc();
	setcookie('loged', $row['id'], time()+3600);
	$_COOKIE['loged'] = $row['id'];
	setcookie('tst', hash(sha256, $login), time()+3600);
	$_COOKIE['tst'] = sha1($login);
	
	$database->close();
	return false;
}

function logout()
{
	setcookie('loged"', 0, time());
	setcookie('tst', "", time());
	unset($_COOKIE['loged']);
	unset($_COOKIE['tst']);
	return false;
}

function stay_loged()
{
	if (isset($_COOKIE['loged']) && isset($_COOKIE['tst']))
	{
		if (!$database = DBconnect())
			{	return "DB error - cannot connect";	}
		$result = $database->query("select login from users where id = ".$_COOKIE['loged']." ;");
		$row = $result->fetch_assoc();
		if ( hash(sha256, $row['login']) != $_COOKIE['tst'] )
		{
			logout();
			return "cookie error";
		}
		setcookie('loged', $_COOKIE['loged'], time()+3600);
		setcookie('tst', hash(sha256, $row['login']), time()+3600);
		return false;
	}
	else if (isset($_COOKIE['loged']) || isset($_COOKIE['tst']))
		{	logout();	}
}

?>
