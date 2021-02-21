<?php

namespace CustomLastSeen;

use Shopware\Components\Plugin;
use Doctrine\Common\Collections\ArrayCollection;
use Shopware\Components\Plugin\Context\ActivateContext;
use Shopware\Components\Plugin\Context\DeactivateContext;
use Shopware\Components\Plugin\Context\UninstallContext;

/**
 * Shopware-Plugin CustomLastSeen.
 */
class CustomLastSeen extends Plugin
{
    /**
     * To get events
     *
     * @return array
     */
    public static function getSubscribedEvents()
    {
        return [
            'Theme_Compiler_Collect_Plugin_Javascript' => 'addJsFiles',
            'Theme_Compiler_Collect_Plugin_Less' => 'addLessFiles',
            'Enlight_Controller_Action_PreDispatch' => 'onPreDispatch',
            'Enlight_Controller_Action_PostDispatch_Frontend' => 'onPostDispatch',
        ];
    }
    public function deactivate(DeactivateContext $DeactivateContext)
    {
        parent::deactivate($DeactivateContext);
        $DeactivateContext->scheduleClearCache(DeactivateContext::CACHE_LIST_ALL);
    }

    /**
     * {@inheritdoc}
     */
    public function activate(ActivateContext $activateContext)
    {
        parent::activate($activateContext);
        $activateContext->scheduleClearCache(ActivateContext::CACHE_LIST_ALL);
    }
	public function uninstall(UninstallContext $uninstallContext)
	{
		parent::uninstall($uninstallContext);
		$uninstallContext->scheduleClearCache(UninstallContext::CACHE_LIST_ALL);
	}
    /**
     * Provides the less files for compression
     *
     * @return ArrayCollection
     */
    public function addLessFiles()
    {
        $less = new \Shopware\Components\Theme\LessDefinition(
            [], // configuration
            [__DIR__ . '/Resources/views/frontend/_public/src/css/custom.css'],
            __DIR__ // import directory
        );

        return new ArrayCollection([$less]);
    }
    public function onPostDispatch(\Enlight_Event_EventArgs $args)
    {
        $config = $this->getConfig();
        if ($config['active']) {
            $view     = $args->getSubject()->View();
            $view->assign('cLastSeenProduct', true);
            $version = Shopware()->Config()->get('Version');
            $versions = substr($version, 0, 3);
            $view->assign('shopware_version', $versions);
        }
    }
    /**
     * getting the configurations
     *
     * @param null
     */
    public function getConfig()
    {
        $shop = false;
        if (Shopware()->Container()->has('shop')) {
            $shop =  Shopware()->Container()->get('shop');
        }
        if (!$shop) {
            $shop =  Shopware()->Container()->get('models')->getRepository(\Shopware\Models\Shop\Shop::class)->getActiveDefault();
        }
        $config =  Shopware()->Container()->get('shopware.plugin.config_reader')->getByPluginName('CustomLastSeen', $shop);
        return $config;
    }
    public function onPreDispatch()
    {
        Shopware()->Template()->addTemplateDir(__dir__ . '/Resources/views/');
    }
    /**
     * To add js file
     * @param \Enlight_Event_EventArgs $args
     * @return array
     */
    public function addJsFiles(\Enlight_Event_EventArgs $args)
    {
        $version = Shopware()->Config()->get('Version');
        $versions = substr($version, 0, 3);
        $jsFiles = array(
                __DIR__ . '/Resources/views/frontend/_public/src/js/custom.js',
                __DIR__ . '/Resources/views/frontend/_public/src/js/slider/custom.js',
                );
        return new ArrayCollection($jsFiles);
    }
}
