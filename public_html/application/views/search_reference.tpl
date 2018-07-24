{foreach $reference as $rel}
	<div style="padding:2px 0 2px 4px;border-bottom:1px solid #888;">
		<img src="{$docpath}/files/restypes/{$rel.resource_type}.png" class="thumb_mini" style="margin:2px;">
		<div style="display:inline-block;vertical-align:top;margin-top:8px;">
			<p style="display:inline-block;margin:0 0 0 5px;overflow:hidden;text-overflow:ellipsis;white-space:nowrap;max-width:484px;">
				{if !empty($rel.title_romaji)}
					{$rel.title_romaji} | {$rel.title}{if !empty($rel.title_english)} | {$rel.title_english}{/if}
				{else}
					{if !empty($rel.title_english)}{$rel.title_english} | {/if}{$rel.title}
				{/if}
			</p>
		</div>
		<div style="float:right;">
			<button type="button" class="btn_relate">relate</button>
		</div>
		<input type="hidden" name2="reference-res_id2[]" value="{$rel.id}">
	</div>
{/foreach}
