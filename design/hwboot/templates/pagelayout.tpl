<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml" xml:lang="{$site.http_equiv.Content-language|wash}" lang="{$site.http_equiv.Content-language|wash}">
    <head>
        <meta charset="utf-8">
        <!--[if lt IE 9]><script src="http://html5shim.googlecode.com/svn/trunk/html5.js"></script><![endif]-->

        {def $basket_is_empty   = cond( $current_user.is_logged_in, fetch( shop, basket ).is_empty, 1 )
             $user_hash         = concat( $current_user.role_id_list|implode( ',' ), ',', $current_user.limited_assignment_value_list|implode( ',' ) )}

        {include uri='design:page_head_displaystyles.tpl'}

        {if is_set( $extra_cache_key )|not}
            {def $extra_cache_key = ''}
        {/if}

        {*** @warning This section needs to happen before the first cache-block declaration. ***}

        {def $pagedata         = ezpagedata()}

        {* Calculate top padding to accomodate our fixed top bars - this will most often be needed in page_header_logo.tpl*}
        {* @todo make heights of top nav bar and website toolbar configurable! *}
        {* @todo whether bars are fixed or not could be made configurable too *}
        {def	$navbar_height = 40
                        $toolbar_height = 34
                        $top_padding = $navbar_height}

        {* @todo make columns configurable! *}
        {* calculate span widths *}
        {def $span_left  = 3
             $span_main  = 9
             $span_right = 3}
        {if and($pagedata.left_menu, $pagedata.extra_menu)}
            {set $span_main = 6}
        {/if}
        {if and($pagedata.left_menu|not, $pagedata.extra_menu|not)}
            {set $span_main = 12}
        {/if}

        {undef $pagedata}

        {*** Section end ***}

        {cache-block keys=array( $module_result.uri, $basket_is_empty, $current_user.contentobject_id, $extra_cache_key )}

        {def $pagedata         = ezpagedata()
             $pagestyle        = $pagedata.css_classes
             $locales          = fetch( 'content', 'translation_list' )
             $pagedesign       = $pagedata.template_look
             $current_node_id  = $pagedata.node_id}

        {include uri='design:page_head.tpl'}
        {include uri='design:page_head_style.tpl'}
        {include uri='design:page_head_script.tpl'}
    </head>

    <body>

        {* Website Toolbar on top, if using a flat top menu *}
        {if and( $pagedata.website_toolbar, $pagedata.is_edit|not, eq($pagedata.top_menu, 'flat_top') )}
                {include uri='design:page_toolbar.tpl'}
                {set $top_padding = sum( $top_padding, $toolbar_height )}
        {/if}

        {*cache-block keys=array( $module_result.uri, $user_hash, $extra_cache_key )*}
        {if $pagedata.top_menu}
            {include uri='design:page_topmenu.tpl'}
        {/if}
        {*/cache-block*}

		{include uri='design:page_header.tpl'}


        <div id="page" class="container">
            {if and( is_set( $pagedata.persistent_variable.extra_template_list ), $pagedata.persistent_variable.extra_template_list|count() )}
                {foreach $pagedata.persistent_variable.extra_template_list as $extra_template}
                    {include uri=concat('design:extra/', $extra_template)}
                {/foreach}
            {/if}

            {cache-block keys=array( $module_result.uri, $user_hash, $extra_cache_key )}

            {if $pagedata.show_path}
                {include uri='design:page_toppath.tpl'}
            {/if}

            <div class="row">


                {if $pagedata.left_menu}
                    <div class="span{$span_left}">
                        {include uri='design:primary_sidebar.tpl'}
                    </div>
                {/if}

                {/cache-block}

                {/cache-block}

                <div class="span{$span_main}">
                    {include uri='design:page_mainarea.tpl'}
                </div>

                {cache-block keys=array( $module_result.uri, $user_hash, $access_type.name, $extra_cache_key )}

                {if is_unset($pagedesign)}
                    {def $pagedata   = ezpagedata()
                         $pagedesign = $pagedata.template_look}
                {/if}

                {if $pagedata.extra_menu}
                    <aside class="span{$span_right}">
                        {include uri='design:secondary_sidebar.tpl'}
                    </aside>
                {/if}
            </div>

        </div>

        {include uri='design:page_footer.tpl'}

        {include uri='design:page_footer_script.tpl'}

        {/cache-block}

        <!--DEBUG_REPORT-->
    </body>
</html>
