<?php
include('php/variables.php');
include('php/functions.php');
session_start();
if (isset($_POST['login_button']))
	{	login(addslashes($_POST['name']), addslashes($_POST['pass']));	}
if (isset($_POST['logout_button']))
{
	session_destroy();
	session_start();
}
if (!isset($_SESSION['userName']) && isset($_POST['login_button']))
	{	$page = page('login');	}
else
	{	$page = page($_GET['page']);	}
include('layout/header.php');
include('layout/menu.php');
include($page[1]);
include('layout/footer.php');

?>
