{if is_unset( $exceeded_limit ) }
    {def $exceeded_limit=false()}
{/if}

<form class="well" action={concat($module.functions.removeobject.uri)|ezurl} method="post" name="ObjectRemove">

<div class="alert alert-danger">
{if eq( $exceeded_limit, true() )}
<h2>Warning:</h2>
<p>{'The items contain more than the maximum possible nodes for subtree removal and will not be deleted. You can remove this subtree using the ezsubtreeremove.php script.'|i18n( 'design/ezwebin/node/removeobject' )}</p>
{else}
<h2>{"Are you sure you want to remove these items?"|i18n("design/ezwebin/node/removeobject")}</h2>
{/if}
<ul>
{foreach $remove_list as $remove_item}
    {if $remove_item.childCount|gt(0)}
        <li>{"%nodename and its %childcount children. %additionalwarning"
             |i18n( 'design/ezwebin/node/removeobject',,
                    hash( '%nodename', $remove_item.nodeName,
                          '%childcount', $remove_item.childCount,
                          '%additionalwarning', $remove_item.additionalWarning ) )}</li>
    {else}
        <li>{"%nodename %additionalwarning"
             |i18n( 'design/ezwebin/node/removeobject',,
                    hash( '%nodename', $remove_item.nodeName,
                          '%additionalwarning', $remove_item.additionalWarning ) )}</li>
    {/if}
{/foreach}
</ul>
</div>

{if and( $move_to_trash_allowed, eq( $exceeded_limit, false() ) )}
  <input type="hidden" name="SupportsMoveToTrash" value="1" />
  <p><label class="checkbox">{'Move to trash'|i18n('design/ezwebin/node/removeobject')}<input type="checkbox" name="MoveToTrash" value="1" checked="checked" /></label></p>

  <p><strong>{"Note"|i18n("design/ezwebin/node/removeobject")}:</strong> {"If %trashname is checked, removed items can be found in the trash."
                                                    |i18n( 'design/ezwebin/node/removeobject',,
                                                           hash( '%trashname', concat( '<i>', 'Move to trash' | i18n( 'design/ezwebin/node/removeobject' ), '</i>' ) ) )}</p>
  <br />
{/if}


{include uri="design:gui/button.tpl" name=Store id_name=ConfirmButton value="Confirm"|i18n("design/ezwebin/node/removeobject") disabled=$exceeded_limit extra_btn_classes="btn-danger"}
{include uri="design:gui/defaultbutton.tpl" name=Discard id_name=CancelButton value="Cancel"|i18n("design/ezwebin/node/removeobject")}

</form>
