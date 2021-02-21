;(function ($) {
    var emptyObj = {};

$.overridePlugin('swLastSeenProducts', {

        defaults: {

            /**
             * Limit of the products showed in the slider
             *
             * @property productLimit
             * @type {Number}
             */
            productLimit: 20,

            /**
             * Base url used for uniquely identifying an article
             *
             * @property baseUrl
             * @type {String}
             */
            baseUrl: '/',

            /**
             * ID of the current shop used for uniquely identifying an article.
             *
             * @property shopId
             * @type {Number}
             */
            shopId: 1,

            /**
             * Article that will be added to the list when we are
             * on the detail page.
             *
             * @property currentArticle
             * @type {Object}
             */
            currentArticle: emptyObj,

            /**
             * Selector for the product list used for the product slider
             *
             * @property listSelector
             * @type {String}
             */
            listSelector: '.last-seen-products--slider',

            /**
             * Selector for the product slider container
             *
             * @property containerSelector
             * @type {String}
             */
            containerSelector: '.last-seen-products--container',

            /**
             * Class that will be used for a single product slider items
             *
             * @property itemCls
             * @type {String}
             */
            itemCls: 'last-seen-products--item product-slider--item product--box box--slider',

            /**
             * Class that will be used for the product title
             *
             * @property titleCls
             * @type {String}
             */
            titleCls: 'last-seen-products-item--title product--title',

            /**
             * Class that will be used for the product image
             *
             * @property imageCls
             * @type {String}
             */
            imageCls: 'last-seen-products-item--image product--image',

            /**
             * Picture source when no product image is available
             *
             * @property noPicture
             * @type {String}
             */
            noPicture: ''
        },
	
		/**
         * Creates a product slider item template.
         *
         * @public
         * @method createTemplate
         * @param {Object} article
         */
        createTemplate: function (article) {
            var me = this,
                $template = $('<div>', {
                    'class': me.opts.itemCls,
                    'html': [
                        me.createProductImage(article),
                        me.createProductTitle(article),
                        me.createProductPrice(article)
                    ],
                    'data-ordernumber': article.orderNumber
                });

            $.publish('plugin/swLastSeenProducts/onCreateTemplate', [ me, $template, article ]);

            return $template;
        },
       /**
         * Creates the product name title by the provided article data
         *
         * @public
         * @method createProductTitle
         * @param {Object} data
         */
        createProductPrice: function (data) {
            var me = this,
            element = $('<div>', {
                'class': 'product--price-info',
                'title': data.articleName
            });
			imageEl = $('<div>', { 'class': 'product--price' }).appendTo(element);
			 $('<span>', {
                'class': 'price--default ',
                'html': data.price
            }).appendTo(imageEl);
            
            $.publish('plugin/swLastSeenProducts/onCreateProductPrice', [ me, element, data ]);

            return element;
        }

        
});
}(jQuery));
