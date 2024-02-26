<?php
if (!defined('_PS_VERSION_')) {
    exit;
}

class QRCodePayment extends PaymentModule
{
    public function __construct()
    {
        $this->name = 'qrcodepayment';
        $this->tab = 'payments_gateways';
        $this->version = '1.0.0';
        $this->author = 'Your Name';
        $this->need_instance = 0;
        $this->bootstrap = true;

        parent::__construct();

        $this->displayName = $this->l('QR Code Payment');
        $this->description = $this->l('Accept payments via QR Code.');

        $this->confirmUninstall = $this->l('Are you sure you want to uninstall?');

        if (!Configuration::get('QR_CODE_PAYMENT')) {
            $this->warning = $this->l('No name provided');
        }
    }

    public function install()
    {
        if (parent::install() &&
            $this->registerHook('paymentOptions') &&
            Configuration::updateValue('QR_CODE_PAYMENT', 'My QR Code Payment')
        ) {
            return true;
        }

        return false;
    }

    public function uninstall()
    {
        if (parent::uninstall() &&
            Configuration::deleteByName('QR_CODE_PAYMENT')
        ) {
            return true;
        }

        return false;
    }

    public function hookPaymentOptions($params)
    {
        if (!$this->active) {
            return;
        }

        $paymentForm = $this->context->smarty->fetch('module:qrcodepayment/views/templates/hook/payment_option.tpl');

        $newOption = new PrestaShop\PrestaShop\Core\Payment\PaymentOption();
        $newOption->setCallToActionText($this->l('Pay with QR Code'))
                  ->setAction($this->context->link->getModuleLink($this->name, 'validation', array(), true))
                  ->setForm($paymentForm);

        return array($newOption);
    }
}
