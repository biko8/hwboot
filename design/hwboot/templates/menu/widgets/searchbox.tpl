<form action={"/content/search"|ezurl} class="pull-right navbar-search">
    {if $pagedata.is_edit}
        <input id="searchtext" class="search-query disabled" type="text" name="SearchText" value="" placeholder="{'Search text'|i18n('design/ezwebin/pagelayout')}">
        <button id="searchbutton" class="btn btn-disabled" title="{'Search'|i18n('design/ezwebin/pagelayout')}" type="button">{'Search'|i18n('design/ezwebin/pagelayout')}</button>
    {else}
        <input id="searchtext" class="search-query" type="text" name="SearchText" value="" placeholder="{'Search text'|i18n('design/ezwebin/pagelayout')}">
        {* <button id="searchbutton" class="btn" title="{'Search'|i18n('design/ezwebin/pagelayout')}" type="submit">{'Search'|i18n('design/ezwebin/pagelayout')}</button> *}
        {if eq( $ui_context, 'browse' )}<input name="Mode" type="hidden" value="browse" />{/if}
    {/if}
</form>
