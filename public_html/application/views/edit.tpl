<div style="text-align:left;width:920px;margin:0 auto;">
	<div style="text-align:center;margin-top:15px;">

		<form id="edit_resource_title_form" method="post" action="" enctype="multipart/form-data">

			<div id="res_title" style="margin: 0 20px 20px 0;">
				<form id="edit_resource_title_form" method="post" action="" enctype="multipart/form-data">
					<table style="margin:0 auto;width:630px;">
						<tr>
							<th style="width:100px;">Title*: 
							<td><input class="text_input" type="text" id="resource-title" name="resource-title" value="{$title}" style="width:500px;"></input>
						<tr>
							<th>Title (romaji): 
							<td><input class="text_input" type="text" name="resource-title_romaji" value="{$title_romaji}" style="width:500px;"></input>
						<tr>
							<th>Title (english): 
							<td><input class="text_input" type="text" name="resource-title_english" value="{$title_english}" style="width:500px;"></input>
					</table>
					<div id="save_edits" style="text-align:center;margin:10px;">
						<input type="submit" class="b" value="Save titles">
						<input type="hidden" name="form_token" value="{$form_token}">
					</div>
				</form>
			</div>

			<hr class="edit">

			<div id="res_storage" style="margin: 0 20px 20px 0;">
				<form id="edit_resource_title_form" method="post" action="" enctype="multipart/form-data">
					<table style="margin:0 auto;width:630px;">
						<tr>
							<th>Stored*: 
							<td>
								<select class="text_input" name="resource-storage_id" id="resource-storage_id" style="min-width:160px;">
									{foreach from=$storages item=st}
										<option value="{$st.id}" {if $st.id == $storage_id}selected="selected"{/if}>{$st.name}</option>
									{/foreach}
								</select>
								<button type="button" id="addStorage">Add new</button>
						<tr>
							<th>Directory*: 
							<td><input class="text_input" type="text" id="resource-directory" name="resource-directory" value="{$directory}" style="width:500px;"></input>
					</table>
					<div id="save_edits" style="text-align:center;margin:10px;">
						<input type="submit" class="b" value="Save storage">
						<input type="hidden" name="form_token" value="{$form_token}">
					</div>
				</form>
			</div>

			<hr class="edit">

			<div id="res_images" style="margin: 0 20px 20px 0;">
				<div id="images" style="width:630px;margin:0 auto;text-align:left;margin-bottom:20px;">
					<form id="edit_resource_images_form" method="post" action="" enctype="multipart/form-data">
						<p class="div_title">Thumbnail: </p>
						<div style="padding-left:5px;">
							<table style="width:100%;"><tr>
								<td>
									{if !empty($thumb)}
										<div style="margin: 0 10px;">
											<img style="max-height:150px;max-width:150px;" class="image_small" src="{$docpath}/image/thumb/{$thumb.id}/thumb_{$thumb.id}"></img>
										</div>
									{/if}

								<td style="text-align:center;">
									{if !empty($thumb)}
									<div>
										<button id="remove_thumb" type="button"><b>Remove thumbnail</b></button>
										<br>or
									</div>
									{/if}

									<div style="text-align:left;">
										<p class="div_title">Choose new thumbnail:</p>
										<div>
											<input class="file-thumb file_input" type="file" name="thumb-thumb">
											<button type="button" class="reset_thumb">remove</button>
										</div>
									</div>
							</table>
						</div>

						<hr class="edit_in">

						<p class="div_title">Images: </p>
						<div style="padding-left:5px;margin-bottom:10px;">
							<table style="width:100%;">
							{if !empty($images)}
								{assign var="tr" value=0}
								{foreach $images as $img}
									{if $tr==0}
										<tr>
									{/if}
										<td style="padding:2px;">
											<div class="editor_img">
												<table><tr>
													<td>
														<img class="image_small editor_image" src="{$docpath}/image/index/{$img.id}/{$img.filename}">
													<td style="width:100%;text-align:center;">
														<button id="remove_img" type="button" rmvid="{$img.id}"><b>Remove image</b></button>
												</table>
											</div>
									{assign var="tr" value=($tr+1)%2}
								{/foreach}
							{/if}
							</table>
						</div>

						<p class="div_title">Add images:</p>
						<div style="padding-left:5px;margin-bottom:10px;">
							<div>
								<input class="file-image file_input" type="file" name="image-image[]">
								<button type="button" class="reset_image">remove</button>
							</div>
						</div>

						<div id="save_edits" style="text-align:center;margin-top:20px;">
							<input type="submit" class="b" value="Save thumbnail and images">
							<input type="hidden" name="form_token" value="{$form_token}">
						</div>
					</form>
				</div>
			</div>

			<hr class="edit">

			<div id="res_info" style="margin: 0 20px 20px 0;">
				<div style="width:630px;margin:0 auto;text-align:left;margin-bottom:20px;">
					<form id="edit_resource_info_form" method="post" action="" enctype="multipart/form-data">

						<p class="div_title">Info: </p>
						<div style="margin-left:8px;margin-bottom:20px;">
							<textarea id="info-text_textarea" name="info-text_data">{$text_data}</textarea>
						</div>

						<div id="save_edits" style="text-align:center;margin-top:20px;">
							<input type="submit" class="b" value="Save info">
							<input type="hidden" name="form_token" value="{$form_token}">
						</div>
					</form>
				</div>
			</div>

			<hr class="edit">

			<div id="res_references" style="margin: 0 20px 20px 0;">
				<div style="width:630px;margin:0 auto;text-align:left;margin-bottom:20px;">
					<form id="edit_resource_refs_form" method="post" action="" enctype="multipart/form-data">

						<p class="div_title">Related: </p>

						<div id="selected_reference" style="line-height:12px;margin-left:10px;width:610px;border:1px solid #888;box-shadow:2px 2px 1px #444;">
							{foreach $references as $ref}
								<div style="padding:2px 0 2px 4px;border-bottom:1px solid #888;">
									<img src="{$docpath}/files/restypes/{$ref.resource_type}.png" class="thumb_mini" style="margin:2px;">
									<div style="display:inline-block;vertical-align:top;margin-top:8px;">
										<p style="display:inline-block;margin:0 0 0 5px;overflow:hidden;text-overflow:ellipsis;white-space:nowrap;max-width:484px;">
											{if !empty($ref.title_romaji)}
												{$ref.title_romaji} | {$ref.title}{if !empty($ref.title_english)} | {$ref.title_english}{/if}
											{else}
												{if !empty($ref.title_english)}{$ref.title_english} | {/if}{$ref.title}
											{/if}
										</p>
									</div>
									<div style="float:right;">
										<button type="button" class="btn_relate b">remove</button>
									</div>
									<input type="hidden" name="reference-res_id2[]" value="{$ref.id}">
								</div>
							{/foreach}
						</div>

						<hr class="edit_in" style="margin-top:15px;margin-bottom:15px;">

						<div id="reference_search_bar">
							<p class="div_title" style="display:inline;">Search for related:</p>
							<input type="text" id="reference_search" style="margin-left:10px;width:250px;">
							<button type="button" id="reference_search_btn">Search</button>
							<div id="reference_search_info" style="display:inline-block;"></div>
						</div>
						<div id="reference_search_output" style="line-height:12px;margin:10px 0 0 10px;width:610px;border:1px solid #888;box-shadow:2px 2px 1px #444;display:none;">
						</div>


						<div id="save_edits" style="text-align:center;margin-top:20px;">
							<input type="submit" class="b" value="Save references">
							<input type="hidden" name="form_token" value="{$form_token}">
						</div>
					</form>
				</div>
			</div>

			<hr class="edit">

			<div id="save_all_edits" style="text-align:center;margin-top:20px;">
				<input type="submit" class="b" value="Save all">
				<input type="hidden" name="form_token" value="{$form_token}">
			</div>
		</form>
	</div>
</div>

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

{/literal}

</script>
