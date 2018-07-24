<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Strict//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd">
<html lang="pl" xmlns="http://www.w3.org/1999/xhtml">
<head>
		<meta http-equiv="content-type" content="text/html; charset=UTF-8">
		<link rel="stylesheet" type="text/css" href="{$docpath}/files/style.css" media="screen">
		<script type="text/javascript" src="{$docpath}/files/jquery-1.7.1.min.js"></script>
		<link rel="stylesheet" type="text/css" href="{$docpath}/files/CLEditor1_3_0/jquery.cleditor.css" media="screen">
		<script type="text/javascript" src="{$docpath}/files/CLEditor1_3_0/jquery.cleditor.min.js"></script>
		<script type="text/javascript" src="{$docpath}/files/script.js"></script>
		<title>{$title} | my_desk</title>
</head>
<body {*style="background: #ffffff url('{$docpath}{$bg_image}') center top no-repeat fixed;"*}>
	<div id="page_wrapper">
		<div id="head">
			<img src="{$docpath}{$top_image}" style="display:block;">
			<div id="menu"><!--
				--><a class="menu_button" href="{$docpath}">Main</a><!--
				--><a class="menu_button" href="{$docpath}/addentry/">Add entry</a><!--
				--><a class="menu_button" href="{$docpath}/info/">Info</a><!--

{if isset($edit_resource)}
				--><a class="menu_button" href="{$docpath}/edit/index/{$res_id}">Edit</a><!--
{/if}
				--><a class="menu_button" href="/phpmyadmin">phpmyadmin</a><!--
			--></div>
		</div>

		<div id="content">
			{$content}
		</div>
	</div>

	<div id="bottom">
		&copy;2012 My_desc. Theme by <a href="mailto:nirme.89@gmail.com?Subject=My_desc%20sajt%20dizajn">nirme</a>™® (￣ー￣)
	</div>

	<div id="window_bg" style="display:none;"> </div>

	<div class="window window_style" id="window_add_storage" style="display:none;">
		<div class="window_title">Add new storage device</div>
		<div class="window_content">
			<form style="height:100%;" id="add_storage_form" method="post" action="{$docpath}/ajax/add_storage">
			<table style="margin:0 auto;height:100%;">
				<tr>
					<td>Storage name: 
					<td><input class="wnd_var" type="text" name="storage-name" id="storage-name" style="width:140px;"></input>

				<tr>
					<td colspan="2" style="text-align:center;height:100%;">
						<input style="vertical-align:bottom;" type="submit" value="Add">
			</table>
			</form>
		</div>
	</div>

	<div class="window window_style" id="window_add_company" style="display:none;height:140px;">
		<div class="window_title">Add new galge company</div>
		<div class="window_content">
			<form style="height:100%;" id="add_company_form" method="post" action="{$docpath}/ajax/add_company">
			<table style="margin:0 auto;height:100%;">
				<tr>
					<td>English name: 
					<td><input class="wnd_var" type="text" name="company-name_eng" id="company-name_eng" style="width:140px;"></input>
				<tr>
					<td>Japanese name: 
					<td><input class="wnd_var" type="text" name="company-name_jpn" id="company-name_jpn" style="width:140px;"></input>

				<tr>
					<td colspan="2" style="text-align:center;height:100%;">
						<input style="vertical-align:bottom;" type="submit" value="Add">
			</table>
			</form>
		</div>
	</div>

	<div class="window window_style" id="window_add_platform" style="display:none;">
		<div class="window_title">Add new platform</div>
		<div class="window_content">
			<form style="height:100%;" id="add_platform_form" method="post" action="{$docpath}/ajax/add_platform">
			<table style="margin:0 auto;height:100%;">
				<tr>
					<td>Platform name: 
					<td><input class="wnd_var" type="text" name="platform-name" id="platform-name" style="width:140px;"></input>

				<tr>
					<td colspan="2" style="text-align:center;height:100%;">
						<input style="vertical-align:bottom;" type="submit" value="Add">
			</table>
			</form>
		</div>
	</div>

	<img class="window" id="image_full" src="" src2="{$docpath}/files/loader3.gif">

	<script type="text/javascript">
var DIR = '{$docpath}';
{literal}


$('div#window_bg,#image_full').click(function()
{
	$('#window_bg').hide();
	$('.window').hide();
	$('.window').find('input.wnd_var').val('');
});

function showWnd(wndId)
{
	$('#window_bg').css('height', $(document).height() + 'px').css('width', '100%');
	$('#window_bg').show();

	var w = 0.5 * ($(window).width() - $('#' + wndId).outerWidth());
	var h = 0.5 * ($(window).height() - $('#' + wndId).outerHeight());
	$('#' + wndId).css('top', h + 'px').css('left', w + 'px');
	$('#' + wndId).show();
}

$('button#addStorage').click(function()
{
	showWnd('window_add_storage');
});

$('#add_storage_form').submit(function()
{
	if ($(this).find('input#storage-name').val().length == 0)
	{
		alert('You need to add name of new storage device!');
		return false;
	}
	
	var storageName = $(this).find('#storage-name').val();

	$.ajax(
	{
		url: DIR + '/ajax/add_storage',
		data: ({storage_name: storageName}),
		type: 'POST',
		success: function(d)
		{
			var nfo = JSON.parse(d);
			if (nfo.code == 1)
			{
				alert('Error!');
				return;
			}

			if ($('select#resource-storage_id').length == 0)
				return;

			if (nfo.existing != 0)
			{
				$('select#resource-storage_id').val(nfo.existing);
				return;
			}

			var i=0;
			var str = '';
			for (i;i<nfo.storages.length;i++)
			{
				str += '<option value="' + nfo.storages[i].id + '">' + nfo.storages[i].name + '</option>';
			}
			$('select#resource-storage_id').html(str);
			$('select#resource-storage_id').val(nfo.id);
		},
		error: function(jqXHR, textStatus, errorThrown)
		{
			alert(jqXHR + '<br>' + textStatus + '<br>' + errorThrown);
		}
	});
	$('div#window_add_storage').hide();
	$('div#window_bg').hide();

	return false;
});

$('button#addCompany').click(function()
{
	showWnd('window_add_company');
});

$('#add_company_form').submit(function()
{
	var nameEng = $(this).find('input#company-name_eng').val();
	var nameJpn = $(this).find('input#company-name_jpn').val();

	if (nameEng.length == 0 && nameJpn.length == 0)
	{
		alert('You need to add name of new company!');
		return false;
	}
	
	$.ajax(
	{
		url: DIR + '/ajax/add_company',
		data: ({name_eng: nameEng, name_jpn: nameJpn}),
		type: 'POST',
		success: function(d)
		{
			var nfo = JSON.parse(d);
			if (nfo.code == 1)
			{
				alert('Error!');
				return;
			}

			if ($('select#galge-company_id').length == 0)
				return;

			if (nfo.existing != 0)
			{
				$('select#galge-company_id').val(nfo.existing);
				return;
			}

			var i=0;
			var str = '<option value="0">unknown</option>';
			var tmp='qqq';
			for (i;i<nfo.companys.length;i++)
			{
				if (nfo.companys[i].name_eng.length > 0 && nfo.companys[i].name_jpn.length > 0)
					tmp = nfo.companys[i].name_eng + ' / ' + nfo.companys[i].name_jpn;
				else if (nfo.companys[i].name_eng.length > 0)
					tmp = nfo.companys[i].name_eng;
				else
					tmp = nfo.companys[i].name_jpn;

				str += '<option value="' + nfo.companys[i].id + '">' + tmp + '</option>';
			}
			$('select#galge-company_id').html(str);
			$('select#galge-company_id').val(nfo.id);
		},
		error: function(jqXHR, textStatus, errorThrown)
		{
			alert(jqXHR + '<br>' + textStatus + '<br>' + errorThrown);
		}
	});

	$('div#window_add_company').hide();
	$('div#window_bg').hide();

	return false;
});

$('button#addPlatform').click(function()
{
	showWnd('window_add_platform');
});

$('#add_platform_form').submit(function()
{
	var name = $(this).find('input#platform-name').val();

	if (name.length == 0)
	{
		alert('You need to add name of new platform!');
		return false;
	}

	$.ajax(
	{
		url: DIR + '/ajax/add_platform',
		data: ({platformname: name}),
		type: 'POST',
		success: function(d)
		{
			var nfo = JSON.parse(d);
			if (nfo.code == 1)
			{
				alert('Error!');
				return;
			}

			if ($('select#galge-platform_id').length == 0)
				return;

			if (nfo.existing != 0)
			{
				$('select#galge-platform_id').val(nfo.existing);
				return;
			}

			var i=0;
			var str = '';
			for (i;i<nfo.platforms.length;i++)
			{
				str += '<option value="' + nfo.platforms[i].id + '">' + nfo.platforms[i].name + '</option>';
			}
			$('select#galge-platform_id').html(str);
			$('select#galge-platform_id').val(nfo.id);
		},
		error: function(jqXHR, textStatus, errorThrown)
		{
			alert(jqXHR + '<br>' + textStatus + '<br>' + errorThrown);
		}
	});

	$('div#window_add_platform').hide();
	$('div#window_bg').hide();

	return false;
});

$('.image_small').click(function()
{
	$('#image_full').css('width', '')
					.css('height', '')
					.attr('src', $('#image_full')
					.attr('src2')).attr('class', 'window');

	showWnd('image_full');
	var img = new Image();
	img.onload = function()
	{
		var tw = this.width;
		var th = this.height;
		$('#image_full').attr('src', this.src);
		$('#image_full').attr('class', 'window image_full');
		var wt = ((tw + 20) > $(document).outerWidth()) ? ((tw + 20) + 'px') : '100%';
		var ht = ((th + 20) > $(document).outerHeight()) ? ((th + 20) + 'px') : $(document).outerHeight() + 'px';
		$('#window_bg').animate({width: wt, height: ht}, 900);
		var w = 0.5 * ($(window).width() - tw);
		w = w < 0 ? 0 : w;
		var h = 0.5 * ($(window).height() - th) + $(window).scrollTop();
		h = h < 0 ? 0 : h;
		$('#image_full').css('width', $('#image_full').width())
						.css('height', $('#image_full').height())
						.css('opacity', '0.0');
		$('#image_full').animate({top: h, left: w, opacity: 1.0, width: tw, height: th}, 900);
		
	}

	img.src = $(this).attr('src');
});

{/literal}
	</script>

</body>

</html>
