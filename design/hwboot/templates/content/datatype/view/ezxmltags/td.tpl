{set $classification = cond( and(is_set( $align ), $align ), concat( $classification, ' text-', $align ), $classification )}
<td{if $classification} class="{$classification|wash}"{/if}{if $colspan} colspan="{$colspan}"{/if}{if $rowspan} rowspan="{$rowspan}"{/if}{if and(is_set( $scope ), $scope)} scope="{$scope|wash}"{/if}{if and(is_set( $abbr ), $abbr)} abbr="{$abbr|wash}"{/if} >
{switch name=Sw match=$content}
  {case match="<p></p>"}
  &nbsp;
  {/case}
  {case match=""}
  &nbsp;
  {/case}
  {case}
  {$content}
  {/case}
{/switch}
</td>
