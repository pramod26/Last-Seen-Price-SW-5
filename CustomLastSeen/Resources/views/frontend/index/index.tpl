{extends file="parent:frontend/index/index.tpl"}    
    {block name="frontend_index_header_javascript"}
    {if $shopware_version eq '5.6' or $shopware_version eq '5.5'}
        {$controllerData = [
            'vat_check_enabled' => {config name='vatcheckendabled'},
            'vat_check_required' => {config name='vatcheckrequired'},
            'register' => {url controller="register"},
            'checkout' => {url controller="checkout"},
            'ajax_search' => {url controller="ajax_search" _seo=false},
            'ajax_cart' => {url controller='checkout' action='ajaxCart' _seo=false},
            'ajax_validate' => {url controller="register" _seo=false},
            'ajax_add_article' => {url controller="checkout" action="addArticle" _seo=false},
            'ajax_listing' => {url module="widgets" controller="listing" action="listingCount" _seo=false},
            'ajax_cart_refresh' => {url controller="checkout" action="ajaxAmount" _seo=false},
            'ajax_address_selection' => {url controller="address" action="ajaxSelection" fullPath _seo=false},
            'ajax_address_editor' => {url controller="address" action="ajaxEditor" fullPath _seo=false}
        ]}

        {$themeConfig = [
            'offcanvasOverlayPage' => $theme.offcanvasOverlayPage
        ]}

        {$lastSeenProductsKeys = []}
        {foreach $sLastArticlesConfig as $key => $value}
            {$lastSeenProductsKeys[$key] = $value}
        {/foreach}

        {$lastSeenProductsConfig = [
            'baseUrl' => $Shop->getBaseUrl(),
            'shopId' => $Shop->getId(),
            'noPicture' => {link file="frontend/_public/src/img/no-picture.jpg"},
            'productLimit' => {"{config name=lastarticlestoshow}"|floor},
            'currentArticle' => ""
        ]}

        {if $sArticle}
            {$lastSeenProductsConfig.currentArticle = $sLastArticlesConfig}
            {$lastSeenProductsConfig.currentArticle.articleId = $sArticle.articleID}
            {$lastSeenProductsConfig.currentArticle.linkDetailsRewritten = $sArticle.linkDetailsRewrited}
            {$lastSeenProductsConfig.currentArticle.articleName = $sArticle.articleName}
            {if $cLastSeenProduct}
				{$lastSeenProductsConfig.currentArticle.price = {$sArticle.price|currency|cat:" {s name="Star" namespace="frontend/listing/box_article"}{/s}"}} 
                <div class="test">Test Div</div>
			{/if}
            {if $sArticle.additionaltext}
                {$lastSeenProductsConfig.currentArticle.articleName = $lastSeenProductsConfig.currentArticle.articleName|cat:' ':$sArticle.additionaltext}
            {/if}
            {$lastSeenProductsConfig.currentArticle.imageTitle = $sArticle.image.description}
            {$lastSeenProductsConfig.currentArticle.images = []}

            {foreach $sArticle.image.thumbnails as $key => $image}
                {$lastSeenProductsConfig.currentArticle.images[$key] = [
                    'source' => $image.source,
                    'retinaSource' => $image.retinaSource,
                    'sourceSet' => $image.sourceSet
                ]}
            {/foreach}
        {/if}

        {$csrfConfig = [
            'generateUrl' => {url controller="csrftoken" fullPath=false},
            'basePath' => $Shop->getBasePath(),
            'shopId' => $Shop->getId()
        ]}

        {if {config name="shareSessionBetweenLanguageShops"} && $Shop->getMain()}
            {$csrfConfig['shopId'] = $Shop->getMain()->getId()}
        {/if}

        {* let the user modify the data here *}
        {block name="frontend_index_header_javascript_data"}{/block}

        <script id="footer--js-inline">
            {block name="frontend_index_header_javascript_inline"}
                var timeNow = {time() nocache};
                var secureShop = {if $Shop->getSecure() eq 1}true{else}false{/if};

                var asyncCallbacks = [];

                document.asyncReady = function (callback) {
                    asyncCallbacks.push(callback);
                };
                var controller = controller || {$controllerData|json_encode};
                var snippets = snippets || { "noCookiesNotice": {s json="true" name='IndexNoCookiesNotice'}{/s} };
                var themeConfig = themeConfig || {$themeConfig|json_encode};
                var lastSeenProductsConfig = lastSeenProductsConfig || {$lastSeenProductsConfig|json_encode};
                var csrfConfig = csrfConfig || {$csrfConfig|json_encode};
                var statisticDevices = [
                    { device: 'mobile', enter: 0, exit: 767 },
                    { device: 'tablet', enter: 768, exit: 1259 },
                    { device: 'desktop', enter: 1260, exit: 5160 }
                ];
                var cookieRemoval = cookieRemoval || {config name="cookie_note_mode"};

            {/block}
        </script>

        {include file="frontend/index/datepicker-config.tpl"}

        {if $theme.additionalJsLibraries}
            {$theme.additionalJsLibraries}
        {/if}
        
        {elseif $shopware_version eq '5.4'}
          {$controllerData = [
            'vat_check_enabled' => {config name='vatcheckendabled'},
            'vat_check_required' => {config name='vatcheckrequired'},
            'register' => {url controller="register"},
            'checkout' => {url controller="checkout"},
            'ajax_search' => {url controller="ajax_search" _seo=false},
            'ajax_cart' => {url controller='checkout' action='ajaxCart' _seo=$ajaxSeoSupport},
            'ajax_validate' => {url controller="register" _seo=$ajaxSeoSupport},
            'ajax_add_article' => {url controller="checkout" action="addArticle" _seo=$ajaxSeoSupport},
            'ajax_listing' => {url module="widgets" controller="Listing" action="ajaxListing" _seo=$ajaxSeoSupport},
            'ajax_cart_refresh' => {url controller="checkout" action="ajaxAmount" _seo=$ajaxSeoSupport},
            'ajax_address_selection' => {url controller="address" action="ajaxSelection" fullPath _seo=$ajaxSeoSupport},
            'ajax_address_editor' => {url controller="address" action="ajaxEditor" fullPath _seo=$ajaxSeoSupport}
        ]}

        {$themeConfig = [
            'offcanvasOverlayPage' => $theme.offcanvasOverlayPage
        ]}

        {$lastSeenProductsKeys = []}
        {foreach $sLastArticlesConfig as $key => $value}
            {$lastSeenProductsKeys[$key] = $value}
        {/foreach}

        {$lastSeenProductsConfig = [
            'baseUrl' => $Shop->getBaseUrl(),
            'shopId' => $Shop->getId(),
            'noPicture' => {link file="frontend/_public/src/img/no-picture.jpg"},
            'productLimit' => {"{config name=lastarticlestoshow}"|floor},
            'currentArticle' => ""
        ]}

        {if $sArticle}
            {$lastSeenProductsConfig.currentArticle = $sLastArticlesConfig}
            {$lastSeenProductsConfig.currentArticle.articleId = $sArticle.articleID}
            {$lastSeenProductsConfig.currentArticle.linkDetailsRewritten = $sArticle.linkDetailsRewrited}
            {$lastSeenProductsConfig.currentArticle.articleName = $sArticle.articleName}
            {if $sArticle.additionaltext}
                {$lastSeenProductsConfig.currentArticle.articleName = $lastSeenProductsConfig.currentArticle.articleName|cat:' ':$sArticle.additionaltext}
            {/if}
			{if $cLastSeenProduct}
				{$lastSeenProductsConfig.currentArticle.price = {$sArticle.price|currency|cat:" {s name="Star" namespace="frontend/listing/box_article"}{/s}"}} 
			{/if}

            {$lastSeenProductsConfig.currentArticle.imageTitle = $sArticle.image.description}
            {$lastSeenProductsConfig.currentArticle.images = []}

            {foreach $sArticle.image.thumbnails as $key => $image}
                {$lastSeenProductsConfig.currentArticle.images[$key] = [
                    'source' => $image.source,
                    'retinaSource' => $image.retinaSource,
                    'sourceSet' => $image.sourceSet
                ]}
            {/foreach}
        {/if}

        {$csrfConfig = [
            'generateUrl' => {url controller="csrftoken" fullPath=false},
            'basePath' => $Shop->getBasePath(),
            'shopId' => $Shop->getId()
        ]}

        {* let the user modify the data here *}
        {block name="frontend_index_header_javascript_data"}{/block}

        <script type="text/javascript" id="footer--js-inline">
            {block name="frontend_index_header_javascript_inline"}
                var timeNow = {time() nocache};

                var asyncCallbacks = [];

                document.asyncReady = function (callback) {
                    asyncCallbacks.push(callback);
                };
                var controller = controller || {$controllerData|json_encode};
                var snippets = snippets || { "noCookiesNotice": {s json="true" name='IndexNoCookiesNotice'}{/s} };
                var themeConfig = themeConfig || {$themeConfig|json_encode};
                var lastSeenProductsConfig = lastSeenProductsConfig || {$lastSeenProductsConfig|json_encode};
                var csrfConfig = csrfConfig || {$csrfConfig|json_encode};
                var statisticDevices = [
                    { device: 'mobile', enter: 0, exit: 767 },
                    { device: 'tablet', enter: 768, exit: 1259 },
                    { device: 'desktop', enter: 1260, exit: 5160 }
                ];

            {/block}
        </script>

        {include file="frontend/index/datepicker-config.tpl"}

        {if $theme.additionalJsLibraries}
            {$theme.additionalJsLibraries}
        {/if}
        
        
        {elseif $shopware_version eq '5.3'}
        
    <script type="text/javascript" id="footer--js-inline">
        //<![CDATA[
        {block name="frontend_index_header_javascript_inline"}
            var timeNow = {time() nocache};

            var asyncCallbacks = [];

            document.asyncReady = function (callback) {
                asyncCallbacks.push(callback);
            };

            var statisticDevices = [
                { device: 'mobile', enter: 0, exit: 767 },
                { device: 'tablet', enter: 768, exit: 1259 },
                { device: 'desktop', enter: 1260, exit: 5160 }
            ];

            var controller = controller || {ldelim}
                'vat_check_enabled': '{config name='vatcheckendabled'}',
                'vat_check_required': '{config name='vatcheckrequired'}',
                'ajax_cart': '{url controller='checkout' action='ajaxCart'}',
                'ajax_search': '{url controller="ajax_search" _seo=false}',
                'register': '{url controller="register"}',
                'checkout': '{url controller="checkout"}',
                'ajax_validate': '{url controller="register"}',
                'ajax_add_article': '{url controller="checkout" action="addArticle"}',
                'ajax_listing': '{url module="widgets" controller="Listing" action="ajaxListing"}',
                'ajax_cart_refresh': '{url controller="checkout" action="ajaxAmount"}',
                'ajax_address_selection': '{url controller="address" action="ajaxSelection" fullPath forceSecure}',
                'ajax_address_editor': '{url controller="address" action="ajaxEditor" fullPath forceSecure}'
            {rdelim};

            var snippets = snippets || {ldelim}
                'noCookiesNotice': '{"{s name='IndexNoCookiesNotice'}{/s}"|escape}'
            {rdelim};

            var themeConfig = themeConfig || {ldelim}
                'offcanvasOverlayPage': '{$theme.offcanvasOverlayPage}'
            {rdelim};

            var lastSeenProductsConfig = lastSeenProductsConfig || {ldelim}
                'baseUrl': '{$Shop->getBaseUrl()}',
                'shopId': '{$Shop->getId()}',
                'noPicture': '{link file="frontend/_public/src/img/no-picture.jpg"}',
                'productLimit': ~~('{config name="lastarticlestoshow"}'),
                'currentArticle': {ldelim}{if $sArticle}
                    {foreach $sLastArticlesConfig as $key => $value}
                        '{$key}': '{$value}',
                    {/foreach}
                    'articleId': ~~('{$sArticle.articleID}'),
                    'orderNumber': '{$sArticle.ordernumber}',
                    'linkDetailsRewritten': '{$sArticle.linkDetailsRewrited}',
                    'articleName': '{$sArticle.articleName|escape:"javascript"}{if $sArticle.additionaltext} {$sArticle.additionaltext|escape:"javascript"}{/if}',
                    'imageTitle': '{$sArticle.image.description|escape:"javascript"}',
                    'capsule':'{$sArticle.attributes.core.capsules_qty}',
                    'price': '{$sArticle.price|currency|cat:" {s name="Star" namespace="frontend/listing/box_article"}{/s}"}',
                    'images': {ldelim}
                        {foreach $sArticle.image.thumbnails as $key => $image}
                            '{$key}': {ldelim}
                                'source': '{$image.source}',
                                'retinaSource': '{$image.retinaSource}',
                                'sourceSet': '{$image.sourceSet}'
                            {rdelim},
                        {/foreach}
                    {rdelim}
                {/if}{rdelim}
            {rdelim};

            var csrfConfig = csrfConfig || {ldelim}
                'generateUrl': '{url controller="csrftoken" fullPath=false}',
                'basePath': '{$Shop->getBasePath()}',
                'shopId': '{$Shop->getId()}'
            {rdelim};
        {/block}
        //]]>
    </script>


    {include file="frontend/index/datepicker-config.tpl"}

    {if $theme.additionalJsLibraries}
        {$theme.additionalJsLibraries}
    {/if}

        {elseif $shopware_version eq '5.2'}
    <script type="text/javascript">
        //<![CDATA[
        {block name="frontend_index_header_javascript_inline"}
            var timeNow = {time() nocache};

            var controller = controller || {ldelim}
                'vat_check_enabled': '{config name='vatcheckendabled'}',
                'vat_check_required': '{config name='vatcheckrequired'}',
                'ajax_cart': '{url controller='checkout' action='ajaxCart'}',
                'ajax_search': '{url controller="ajax_search"}',
                'register': '{url controller="register"}',
                'checkout': '{url controller="checkout"}',
                'ajax_validate': '{url controller="register"}',
                'ajax_add_article': '{url controller="checkout" action="addArticle"}',
                'ajax_listing': '{url module="widgets" controller="Listing" action="ajaxListing"}',
                'ajax_cart_refresh': '{url controller="checkout" action="ajaxAmount"}',
                'ajax_address_selection': '{url controller="address" action="ajaxSelection" fullPath forceSecure}',
                'ajax_address_editor': '{url controller="address" action="ajaxEditor" fullPath forceSecure}'
            {rdelim};

            var snippets = snippets || {ldelim}
                'noCookiesNotice': '{s name="IndexNoCookiesNotice"}{/s}'
            {rdelim};

            var themeConfig = themeConfig || {ldelim}
                'offcanvasOverlayPage': '{$theme.offcanvasOverlayPage}'
            {rdelim};

            var lastSeenProductsConfig = lastSeenProductsConfig || {ldelim}
                'baseUrl': '{$Shop->getBaseUrl()}',
                'shopId': '{$Shop->getId()}',
                'noPicture': '{link file="frontend/_public/src/img/no-picture.jpg"}',
                'productLimit': ~~('{config name="lastarticlestoshow"}'),
                'currentArticle': {ldelim}{if $sArticle}
                    {foreach $sLastArticlesConfig as $key => $value}
                        '{$key}': '{$value}',
                    {/foreach}
                    'articleId': ~~('{$sArticle.articleID}'),
                    'linkDetailsRewritten': '{$sArticle.linkDetailsRewrited}',
                    'articleName': '{$sArticle.articleName|escape:"javascript"}',
                    'imageTitle': '{$sArticle.image.description|escape:"javascript"}',
                    'price': '{$sArticle.price|currency|cat:" {s name="Star" namespace="frontend/listing/box_article"}{/s}"}',
                    'images': {ldelim}
						{foreach $sArticle.image.thumbnails as $key => $image}
							'{$key}': {ldelim}
                                'source': '{$image.source}',
                                'retinaSource': '{$image.retinaSource}',
                                'sourceSet': '{$image.sourceSet}'
                            {rdelim},
						{/foreach}
					{rdelim}
                {/if}{rdelim}
            {rdelim};

            var csrfConfig = csrfConfig || {ldelim}
                'generateUrl': '{url controller="csrftoken" fullPath=false}',
                'basePath': '{$Shop->getBasePath()}',
                'shopId': '{$Shop->getId()}'
            {rdelim};
        {/block}
        //]]>
	</script>

    {if $theme.additionalJsLibraries}
        {$theme.additionalJsLibraries}
    {/if}

        {else} 
        {$smarty.block.parent}
        {/if}
    {/block}
