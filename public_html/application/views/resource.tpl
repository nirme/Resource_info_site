<div style="text-align:left;width:920px;margin:0 auto;">
	<div style="text-align:center;margin-top:15px;">
		<img src="{$docpath}/files/restypes/{$resource_type}.png">
		<div class="resource_titles" style="display:inline-block;max-width:840px">
			{if !empty($title_romaji)}
				<p>{$title_romaji}</p>
				<p>{$title}</p>
				{if !empty($title_english)}
					<p>{$title_english}</p>
				{/if}
			{else}
				{if !empty($title_english)}
					<p>{$title_english}</p>
				{/if}
				<p>{$title}</p>
			{/if}
		</div>
	</div>

	<div style="vertical-align:top;margin-left:50px;">
	{if !empty($thumb)}
		<div style="display:inline-block;">
			<img style="max-height:200px;max-width:200px;" class="image_small" src="{$docpath}/image/thumb/{$thumb.id}/thumb_{$thumb.id}"></img>
		</div>
	{/if}
		<div style="display:inline-block;vertical-align:top;{if !empty($thumb)}max-width:660px{/if}">
			<table class="resource_info">
				<tr>
					<th>Stored in: 
					<td>{$storage}
				<tr>
					<th>Directory: 
					<td>{$directory}

			{if $resource_type == 1 || $resource_type == 5 || $resource_type == 9}
				<tr>
					<th>Audio language: 
					<td>{$audio}
				<tr>
					<th>Subtitles language: 
					<td>{$subtitles}
				<tr>
					<th>Group: 
					<td>{$subgroup}
				<tr>
					<th>Format: 
					<td>{$format_info}

			{elseif $resource_type == 2 ||  $resource_type == 4}
				<tr>
					<th>Author: 
					<td>{$author}

			{elseif $resource_type == 3}
				<tr>
					<th>Release date: 
					<td>{$release_date}
				<tr>
					<th>Company: 
					<td>{$company_eng|default:''}{if !empty($company_eng) && !empty($company_jpn)} / {/if}{$company_jpn|default:''}
				<tr>
					<th>Platform: 
					<td>{$platform}

			{elseif $resource_type == 6 || $resource_type == 7 || $resource_type == 8}
				<tr>
					<th>Format: 
					<td>{$format_info}

			{/if}
			</table>
		</div>
	</div>


	{if isset($text_data)}
		<hr class="res">
		<div style="text-align:left;width:800px;margin:10px auto 10px auto;">
			{$text_data}
		</div>
	{/if}

	{if !empty($images)}
		<hr class="res">
		<div style="text-align:center;width:840px;margin:10px auto 10px auto;">
		{foreach $images as $img}
			<img style="max-width:190px;max-height:160px;" class="image_small additional_image" src="{$docpath}/image/index/{$img.id}/{$img.filename}">
		{/foreach}
		</div>
	{/if}

	{if !empty($references)}
		<hr class="res">
		<div style="margin:0 0 15px 70px;text-align:left;">
			<table style="margin:0;">
				<tr><th colspan="2" style="padding:0 0 8px 0;font-size:14px;">Similar entries: 
				{foreach $references as $ref}
				<tr>
					<td style="padding-left:20px;"><img class="thumb_mini" src="{$docpath}/files/restypes/{$ref.resource_type}.png">
					<td style="padding-left:10px;vertical-align:middle;">
						<a class="refs" href="{$docpath}/resource/index/{$ref.id}">
						{if !empty($ref.title_romaji)}
							{$ref.title_romaji} | {$ref.title}{if !empty($ref.title_english)} | {$ref.title_english}{/if}
						{else}
							{if !empty($ref.title_english)}{$ref.title_english} | {/if}{$ref.title}
						{/if}
						</a>
				{/foreach}
			</table>
		</div>
	{/if}
	<hr class="res">
</div>
