
<form id="category_form" method="post" action="{$docpath}/main/index/1">
<div id="search_container" style="margin:15px 40px 20px 30px;">
	<div id="category" style="vertical-align:middle;width:420px;">
		<table>
			<tr>
				{assign var='cols' value=0}
				{foreach from=$restype item=rt}
				{if $cols == 5}
					<tr>
					{assign var='cols' value=0}
				{/if}
				
				<td><input type="checkbox" name="res_type[]" value="{$rt.id}" {if isset($typeq) && $typeq[$rt.id]} checked="checked"{/if} class="category_select">
						<a href="{$docpath}/main/index/1/{pow(2,$rt.id - 1)}">{$rt.name}</a>
					</input>
				{assign var='cols' value=$cols+1}
				{/foreach}

				<td style="text-align:center;">
					<button type="button" id="category_select_all"><b>Select all</b></button>

		</table>
	</div>
	<div id="search" style="vertical-align:middle;text-align:right;width:480px;">
		<input class="text_input" type="text" name="res_search" value="{if isset($search)}{$search}{/if}" style="width:350px;text-align:right;"></input>
		<input type="submit" value="Search">
	</div>
</div>
</form>

<div>

	<div class="paginator">
	{if $page > 1}<a href="{$docpath}/main/index/{$page - 1}/{if is_int($type)}{$type}{else}0{/if}{if isset($searchUrl)}/{$searchUrl}{/if}"><-</a>{else}<p><-</p>{/if}<!--
		{section name=pg loop=$pages}
			{if ($smarty.section.pg.iteration) != $page}
			--><a href="{$docpath}/main/index/{$smarty.section.pg.iteration}/{if is_int($type)}{$type}{else}0{/if}{if isset($searchUrl)}/{$searchUrl}{/if}">
				{$smarty.section.pg.iteration}
			</a><!--
			{else}
			--><p class="actual_page">{$smarty.section.pg.iteration}</p><!--
			{/if}	
		{/section}
	-->{if $page < $pages}<a href="{$docpath}/main/index/{$page + 1}/{if is_int($type)}{$type}{else}0{/if}{if isset($searchUrl)}/{$searchUrl}{/if}">-></a>{else}<p>-></p>{/if}
	</div>

	<table style="width:960px;" class="resources_table">
		<tr>
			<th style="width:30px;border-top-left-radius:4px;">Type
			<th>Title
			<th style="width:90px;border-top-right-radius:4px;">Stored

		{assign var='par' value=0}
		{foreach from=$resources item=res}
		<tr {if $par++ % 2}class="color"{/if}>
			<td><img src="{$docpath}/files/restypes/{$res.resource_type}.png">
			<td><a href="{$docpath}/resource/index/{$res.id}" class="resource_link">
				{if !empty($res.title_romaji)}
					<p class="title">{$res.title_romaji}</p>
					<p class="sub_title">{$res.title}</p>
					{if !empty($res.title_english)}<p class="sub_title">{$res.title_english}</p>{/if}
				{elseif !empty($res.title_english)}
					<p class="title">{$res.title_english}</p>
					<p class="sub_title">{$res.title}</p>
				{else}
					<p class="title">{$res.title}</p>
				{/if}
				</a>
			<td>{$res.storage_name}
		{/foreach}
	</table>

	<div class="paginator">
	{if $page > 1}<a href="{$docpath}/main/index/{$page - 1}"><-</a>{else}<p><-</p>{/if}<!--
		{section name=pg loop=$pages}
			{if ($smarty.section.pg.iteration) != $page}
			--><a href="{$docpath}/main/index/{$smarty.section.pg.iteration}">
				{$smarty.section.pg.iteration}
			</a><!--
			{else}
			--><p class="actual_page">{$smarty.section.pg.iteration}</p><!--
			{/if}	
		{/section}
	-->{if $page < $pages}<a href="{$docpath}/main/index/{$page + 1}">-></a>{else}<p>-></p>{/if}
	</div>

</div>

<script type="text/javascript">
{literal}
$('#category_select_all').click(function()
{
	$('.category_select').removeAttr('checked');
});

{/literal}
</script>
