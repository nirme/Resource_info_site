<h2>Add resource</h2>

{if isset($added)}
	{if $added}
		New resource has been added:<br>
		<a href="{$docpath}/resource/index/{$id}">{$title}{if !empty($title_ro)} / {$title_ro}{/if}{if !empty($title_en)} / {$title_en}{/if}</a>
		<br>
	{elseif isset($existing_id)}
		Resource by this title already exist:<br>
		<a href="{$docpath}/resource/index/{$existing_id}">{$title}{if !empty($title_ro)} / {$title_ro}{/if}{if !empty($title_en)} / {$title_en}{/if}</a>
	{/if}
{else}
	<form id="add_entry_form" method="post" action="" enctype="multipart/form-data">
	<div id="res_base" style="margin: 0 20px 20px 0;">
		<table style="margin:0 auto;width:630px;">
			<tr>
				<th style="width:100px;">Title*: 
				<td><input class="text_input" type="text" id="resource-title" name="resource-title" style="width:500px;"></input>
			<tr>
				<th>Title (romaji): 
				<td><input class="text_input" type="text" name="resource-title_romaji" style="width:500px;"></input>
			<tr>
				<th>Title (english): 
				<td><input class="text_input" type="text" name="resource-title_english" style="width:500px;"></input>
			<tr>
				<th>Stored*: 
				<td>
					<select class="text_input" name="resource-storage_id" id="resource-storage_id" style="min-width:160px;">
						{foreach from=$storages item=st}
							<option value="{$st.id}">{$st.name}</option>
						{/foreach}
					</select>
					<button type="button" id="addStorage">Add new</button>
			<tr>
				<th>Directory*: 
				<td><input class="text_input" type="text" id="resource-directory" name="resource-directory" style="width:500px;"></input>

			<tr>
				<th>Type*:
				<td>
					<table>
						{assign var='cols' value=0}
						{foreach from=$restype item=rt}
						{if $cols%5 == 0}
							<tr>
						{/if}
						
						<td><input type="radio" class="resource_type" name="resource-resource_type" value="{$rt.id}">{$rt.name}</input>
						{assign var='cols' value=$cols+1}
						{/foreach}
					</table>
		</table>
	</div>


	<div id="notes" style="display:none;text-align:center;margin-bottom:10px;">
		you can separate different information (formats, languages) with comma ','
	</div>

	<div id="res_1" class="add_nfo" style="display:none;">
	<table style="margin:0 auto;width:630px;">
		<tr><th style="width:100px;">Language:
			<td><input class="text_input" type="text" name="anime-audio" style="width:160px;"></input>
		<tr><th>Subs language:
			<td><input class="text_input" type="text" name="anime-subtitles" style="width:160px;"></input>
		<tr><th>Subbing group:
			<td><input class="text_input" type="text" name="anime-subgroup" style="width:160px;"></input>
		<tr><th>Format:
			<td><input class="text_input" type="text" name="anime-format_info" style="width:160px;"></input>
	</table>
	</div>

	<div id="res_2" class="add_nfo" style="display:none;">
	<table style="margin:0 auto;width:630px;">
		<tr><th style="width:100px;">Author:
			<td><input class="text_input" type="text" name="artbook-author" style="width:160px;"></input>
	</table>
	</div>

	<div id="res_3" class="add_nfo" style="display:none;">
	<table style="margin:0 auto;width:630px;">
		<tr><th style="width:100px;">Release date:
			<td><input class="text_input" type="text" name="galge-release_date" style="width:160px;"></input>
			Acceptable formats: YYYY-MM-DD, YYYY.MM.DD, [YYMMDD]
		<tr><th>Company:
			<td><select class="text_input" name="galge-company_id" id="galge-company_id" style="min-width:160px;">
					<option value="0">unknown</option>
				{foreach from=$company item=co}
					<option value="{$co.id}">
						{if !empty($co.name_eng) && !empty($co.name_jpn)}
							{$co.name_eng} / {$co.name_jpn}
						{elseif !empty($co.name_eng)}
							{$co.name_eng}
						{else}
							{$co.name_jpn}
						{/if}
					</option>
				{/foreach}
				</select>
				<button type="button" id="findCompany">Find</button>
				<button type="button" id="addCompany">Add new</button>
		<tr><th>Platform:
			<td><select class="text_input" name="galge-platform_id" id="galge-platform_id">
				{foreach from=$platform item=pl}
					<option value="{$pl.id}">{$pl.name}</option>
				{/foreach}
				</select>
				<button type="button" id="addPlatform">Add new</button>
	</table>
	</div>

	<div id="res_4" class="add_nfo" style="display:none;">
	<table style="margin:0 auto;width:630px;">
		<tr><th style="width:100px;">Author:
			<td><input class="text_input" type="text" name="manga-author" style="width:160px;"></input>
	</table>
	</div>

	<div id="res_5" class="add_nfo" style="display:none;">
	<table style="margin:0 auto;width:630px;">
		<tr><th style="width:100px;">Language:
			<td><input class="text_input" type="text" name="movie-audio" style="width:160px;"></input>
		<tr><th>Subs language:
			<td><input class="text_input" type="text" name="movie-subtitles" style="width:160px;"></input>
		<tr><th>Subbing group:
			<td><input class="text_input" type="text" name="movie-subgroup" style="width:160px;"></input>
		<tr><th>Format:
			<td><input class="text_input" type="text" name="movie-format_info" style="width:160px;"></input>
	</table>
	</div>

	<div id="res_6" class="add_nfo" style="display:none;">
	<table style="margin:0 auto;width:630px;">
		<tr><th style="width:100px;">Format:
			<td><input class="text_input" type="text" name="music-format_info" style="width:160px;"></input>
	</table>
	</div>

	<div id="res_7" class="add_nfo" style="display:none;">
	<table style="margin:0 auto;width:630px;">
		<tr><th style="width:100px;">Format:
			<td><input class="text_input" type="text" name="music_video-format_info" style="width:160px;"></input>
	</table>
	</div>

	<div id="res_8" class="add_nfo" style="display:none;">
	<table style="margin:0 auto;width:630px;">
		<tr><th style="width:100px;">Format:
			<td><input class="text_input" type="text" name="tv-format_info" style="width:160px;"></input>
	</table>
	</div>

	<div id="res_9" class="add_nfo" style="display:none;">
	<table style="margin:0 auto;width:630px;">
		<tr><th style="width:100px;">Language:
			<td><input class="text_input" type="text" name="hentai-audio" style="width:160px;"></input>
		<tr><th>Subs language:
			<td><input class="text_input" type="text" name="hentai-subtitles" style="width:160px;"></input>
		<tr><th>Subbing group:
			<td><input class="text_input" type="text" name="hentai-subgroup" style="width:160px;"></input>
		<tr><th>Format:
			<td><input class="text_input" type="text" name="hentai-format_info" style="width:160px;"></input>
	</table>
	</div>
<!--
image/gif
GIF image

image/jpeg
JPEG image

image/tiff
TIFF image

image/bmp
Bitmap image

image/png
PNG image
-->
	<div style="margin-right:20px;">
		<div id="images" style="width:630px;margin:0 auto;text-align:left;margin-bottom:20px;">
			<div id="image-thumb" style="margin-bottom:20px;">
				<p class="div_title">Add thumbnail:</p>
				<input class="file-thumb file_input" type="file" name="thumb-thumb">
				<button type="button" class="reset_thumb">remove</button>
			</div>

			<p class="div_title">Add images:</p>
			<div>
				<input class="file-image file_input" type="file" name="image-image[]">
				<button type="button" class="reset_image">remove</button>
			</div>
		</div>

		<div id="info_text" style="width:630px;margin:0 auto;text-align:left;">
			<p class="div_title">Add info:</p>
			<div style="margin-left:8px;margin-bottom:20px;">
				<textarea id="info-text_textarea" name="info-text_data"></textarea>
			</div>
		</div>
		
		<div id="reference_box" style="width:630px;margin:0 auto;text-align:left;">


			<div style="margin-top:20px;">
				<p class="div_title">Related:</p>
				<div id="selected_reference" style="line-height:12px;margin-left:10px;width:610px;border:1px solid #888;box-shadow:2px 2px 1px #444;display:none;">
				</div>
			</div>

			<div id="reference_search_bar" style="margin-top:20px;">
				<p class="div_title" style="display:inline;">Search for related:</p>
				<input type="text" id="reference_search" style="margin-left:10px;width:250px;">
				<button type="button" id="reference_search_btn">Search</button>
				<button type="button" id="reference_clear_btn" style="margin-left:20px;">Clear</button>
				<div id="reference_search_info" style="display:inline-block;"></div>
			</div>
			<div id="reference_search_output" style="line-height:12px;margin:10px 0 0 10px;width:610px;border:1px solid #888;box-shadow:2px 2px 1px #444;display:none;">
			</div>
		</div>

		<div id="res_add" style="text-align:center;margin:30px 20px 10px 20px;">
			<input type="submit" class="b" value=" Add resource ">
			<input type="hidden" name="form_token" value="{$form_token}">
		</div>
	</div>

	</form>

	<script type="text/javascript">
{literal}

$(document).ready(function()
{
	$('#info-text_textarea').cleditor({
		width:610,
		height:250,
		controls:
			"bold italic underline strikethrough | font size | color highlight removeformat | bullets numbering | " +
			" alignleft center alignright justify | undo redo | cut copy paste pastetext | source",
		fonts:
			"Arial,Arial Black,Comic Sans MS,Courier New,Narrow,Garamond," +
			"Georgia,Impact,Sans Serif,Serif,Tahoma,Trebuchet MS,Verdana",
		sizes:
			"1,2,3,4",
		docType:
			'<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01//EN" "http://www.w3.org/TR/html4/strict.dtd">',
		bodyStyle:
			'cursor:text'
		});
});

$('.resource_type').click(function()
{
	$('.add_nfo').slideUp();
	$('#notes').slideDown();
	$('#res_' + $(this).val()).slideDown();
});

$(document).on("change", '.file-image', function()
{
	var flag = true;
	$('.file-image').each(function()
	{
		if ($(this).val().length == 0)
			flag = false;
	});
	
	if (flag)
		$('#images').append('<div><input class="file-image file_input" type="file" name="image-image[]"> ' +
								'<button type="button" class="reset_image">remove</button></div>');
});

$(document).on("click", '.reset_image', function()
{
	if ($('.file-image').length > 1 && $(this).parent().children('input').val().length != 0)
		$(this).parent().remove();
	else
		$(this).parent().children('input').replaceWith('<input class="file-image file_input" type="file" name="image-image[]">');
});

$(document).on("click", '.reset_thumb', function()
{
	$('#image-thumb').children('input').replaceWith('<input class="file-thumb file_input" type="file" name="thumb-thumb"> ');
});

$('#add_entry_form').submit(function()
{
	if ($('#resource-title').val().length < 2)
	{
		alert('You need to add title!');
		return false;
	}

	if ($('#resource-directory').val().length < 2)
	{
		alert('You need to add path to files!');
		return false;
	}

	if ($('.resource_type:checked').length == 0)
	{
		alert('You need to select type of the resource!');
		return false;
	}

	
	return true;
});

$('#reference_search_btn').click(function()
{
	var text = $('#reference_search').val();

	if (text.length < 2)
	{
		alert('Searched word must be at least 2 letters long!');
		return;
	}

	$('#reference_search_output').hide();
	$('#reference_search_output').html('');

	var ids = new Array();
	if ($('#selected_reference').find('input').length)
	{
		var ins = $('#selected_reference').find('input');
		var i=0;
		while (i < ins.length)
			ids.push(ins.eq(i++).val());
	}
	ids = ids.toString();

	$('#reference_search_output').html('');
	$('#reference_search_info').html('<img src="' + DIR + '/files/loader.gif">');
	$('#reference_search_output').hide();

	$.ajax(
	{
		url: DIR + '/ajax/search_reference',
		data: ({title: text, onList: ids}),
		type: 'POST',
		success: function(d)
		{
			if (d == '0')
			{
				$('#reference_search_info').html('nothing found');
				return;
			}

			$('#reference_search_info').html('');
			$('#reference_search_output').html(d);
			$('#reference_search_output').show();
			$('#reference_search').val('');
		},
		error: function(jqXHR, textStatus, errorThrown)
		{
			$('#reference_search_bar').children('img').remove();
			alert(jqXHR + '<br>' + textStatus + '<br>' + errorThrown);
		}
	});

});


$('#reference_clear_btn').click(function()
{
	$('#reference_search').val('');
	$('#reference_search_output').html('');
	$('#reference_search_info').html('');
	$('#reference_search_output').hide();
});


$(document).on("click", '.btn_relate', function()
{
	var t = $(this).parent().parent().find('input');
	t.attr('name', t.attr('name2'));
	$('#selected_reference').append(
		$(this).parent().parent().clone().find('button').html('remove').attr('class','btn_rel_remove').parent().parent().clone()
	);

	$(this).parent().parent().remove();

	$('#selected_reference').show();

	if ($('#reference_search_output').children().length == 0)
	{
		$('#reference_search_output').html('');
		$('#reference_search_output').hide();
	}
});


$(document).on("click", '.btn_rel_remove', function()
{
	$(this).parent().parent().remove();
	if ($('#selected_reference').children().length == 0)
	{
		$('#selected_reference').hide();
		$('#selected_reference').html('');
	}
});

{/literal}
	</script>

{/if}
