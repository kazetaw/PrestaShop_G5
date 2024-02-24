<?php
require_once("lib/PromptPayQR.php");

class OnlinePaymentPaymentModuleFrontController extends ModuleFrontController
{

    public function init()
    {
        parent::init();
        if(!$this->module->active)
        {
            Tools::redirect($this->context->link->getPageLink('order'));
        }
    }
    
    public function initContent()
    {
        $cart = $this->context->cart;
        $total = (float)$cart->getOrderTotal(true, Cart::BOTH);
        $PromptPayQR = new PromptPayQR(); // new object
        $PromptPayQR->size = Configuration::get('PROMPTPAY_SIZE'); // Set QR code size to 8
        $PromptPayQR->id = Configuration::get('PROMPTPAY_ID'); // PromptPay ID
        $PromptPayQR->amount = $total; // Set amount (not necessary)

        parent::initContent();
        $this->context->smarty->assign([
            'QR_GENERATE' => $PromptPayQR->generate(),
            'PRICE' => $total
        ]);
        $this->setTemplate('module:onlinepayment/views/templates/front/payment.tpl');
    }
    
    public function setMedia()
    {
        parent::setMedia();
    }
    
    public function postProcess()
    {
        parent::postProcess();
        if(Tools::isSubmit('placeorder')){
            $file = $_FILES['slip_upload'];
            $ext = substr($file['name'], strrpos($file['name'], '.') + 1);
            $file_name = md5($file['name']) . '.' . $ext;
            move_uploaded_file($file['tmp_name'], dirname(__FILE__) . DIRECTORY_SEPARATOR . 'slips' . DIRECTORY_SEPARATOR . $file_name);

            if(!(!isset($file) || $file['name'] == "" || $file['full_path'] == "" || $file['type'] == "" || $file['tmp_name'] == "" || $file['error'] == 4 || $file['size'] == 0))
            {
                $cart = $this->context->cart;
                $total = (float)$cart->getOrderTotal(true, Cart::BOTH);
                $customer = new Customer($cart->id_customer);
                $this->module->validateOrder($cart->id,Configuration::get('PS_OS_PAYMENT'), $total, $this->module->displayName, null, array(), $this->context->currency->id, false, $customer->secure_key);
                Tools::redirect($this->context->link->getPageLink('order-confirmation', Configuration::get('PS_SSL_ENABLED'), $this->context->language->id, 'id_cart='.$cart->id.'&id_module='.$this->module->id.'&id_order='.$this->module->currentOrder.'&key='.$customer->secure_key));
            }
        }
    }
}
