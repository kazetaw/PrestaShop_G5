{**
  
  * Copyright since 2007 PrestaShop SA and Contributors
  * PrestaShop is an International Registered Trademark & Property of PrestaShop SA
  *
  * NOTICE OF LICENSE
  *
  * This source file is subject to the Academic Free License 3.0 (AFL-3.0)
  * that is bundled with this package in the file LICENSE.md.
  * It is also available through the world-wide-web at this URL:
  * https://opensource.org/licenses/AFL-3.0
  * If you did not receive a copy of the license and are unable to
  * obtain it through the world-wide-web, please send an email
  * to license@prestashop.com so we can send you a copy immediately.
  *
  * DISCLAIMER
  *
  * Do not edit or add to this file if you wish to upgrade PrestaShop to newer
  * versions in the future. If you wish to customize PrestaShop for your
  * needs please refer to https://devdocs.prestashop.com/ for more information.
  *
  * @author    PrestaShop SA and Contributors <contact@prestashop.com>
  * @copyright Since 2007 PrestaShop SA and Contributors
  * @license   https://opensource.org/licenses/AFL-3.0 Academic Free License 3.0 (AFL-3.0)
  *}
  
 {block name='cart_detailed_actions'}
  <div class="checkout cart-detailed-actions js-cart-detailed-actions card-block">
    {if $cart.minimalPurchaseRequired}
      <div class="alert alert-warning" role="alert">
        {$cart.minimalPurchaseRequired}
      </div>
      <div class="text-sm-center">
        <button type="button" class="btn btn-primary disabled" disabled>{l s='Proceed to checkout' d='Shop.Theme.Actions'}</button>
      </div>
    {elseif empty($cart.products) }
      <div class="text-sm-center">
        <button type="button" class="btn btn-primary disabled" disabled>{l s='Proceed to checkout' d='Shop.Theme.Actions'}</button>
      </div>
    {else}
      <div class="text-sm-center">
        <a href="{$urls.pages.order}" class="btn btn-warning">{l s='ออกใบกำกับภาษี' d='Shop.Theme.Actions'}</a>
        {hook h='displayExpressCheckout'}
 
        <!-- ปุ่มจ่ายเงิน -->
        <button type="button" class="btn btn-success" data-toggle="modal" data-target="#paymentModal">
          {l s='จ่ายเงิน' d='Shop.Theme.Actions'}
        </button>
 
        {hook h='displayPaymentTop'}
      </div>
    {/if}
  </div>
 
  <!-- Modal สำหรับจ่ายเงิน -->
  <div class="modal fade" id="paymentModal" tabindex="-1" role="dialog" aria-labelledby="paymentModalLabel" aria-hidden="true">
    <div class="modal-dialog" role="document">
      <div class="modal-content">
        <div class="modal-header">
          <h5 class="modal-title" id="paymentModalLabel">{l s='Payment Options' d='Shop.Theme.Actions'}</h5>
          <button type="button" class="close" data-dismiss="modal" aria-label="Close">
            <span aria-hidden="true">&times;</span>
          </button>
        </div>
        <div class="modal-body">
          <!-- เพิ่มฟอร์มหรือข้อมูลที่เกี่ยวข้องกับการจ่ายเงินที่นี่ -->
          <p>{l s='Choose your payment method and follow the instructions to complete the payment.' d='Shop.Theme.Actions'}</p>
          <form action="/action_page.php">
            <p>Please select your favorite Web language:</p>
            <input type="radio" id="html" name="fav_language" value="Bank" onclick="showBankDetails()" style="display: inline-block; margin-right: 5px;">
            <label for="html" style="display: inline-block; margin-right: 15px;">ธนาคาร</label>
            <input type="radio" id="css" name="fav_language" value="QR" onclick="showQRCode()" style="display: inline-block; margin-right: 5px;">
            <label for="css" style="display: inline-block; margin-right: 15px;">QR Code</label>
            <input type="radio" id="javascript" name="fav_language" value="Promtpay" onclick="showPromptPay()" style="display: inline-block;">
            <label for="javascript" style="display: inline-block;">Promtpay</label>
            <!-- แสดงข้อมูลของธนาคารเมื่อคลิกที่ "ธนาคาร" -->
            <div id="bankDetails" style="display:none;">
              <p>{l s='Bank details: Kbank 0448447561 มหาวิทยาลัยขอนแก่น' d='Shop.Theme.Actions'}</p>
            </div>
            <!-- แสดงข้อมูลของ QR Code เมื่อคลิกที่ "QR Code" -->
            <div id="qrCodeDetails" style="display:none; text-align: center;">
              <img src="https://th.bing.com/th/id/OIP.HHacbpUBSuYqZfXIWFn-IQHaHa?rs=1&pid=ImgDetMain" alt="QR Code Logo" style="width: 100px; border: 1px solid #ccc; padding: 5px;">
            </div>
          </form>
          <!-- เพิ่มฟอร์มหรือข้อมูลเพิ่มเติมตามที่คุณต้องการ -->
        </div>
        <div class="modal-footer">
          <button type="button" class="btn btn-secondary" data-dismiss="modal">{l s='แนบหลักฐานการโอน' d='Shop.Theme.Actions'}</button>
          <!-- เพิ่มปุ่มหรือลิงค์ที่ต้องการให้ผู้ใช้ทำการจ่ายเงิน -->
        </div>
      </div>
    </div>
  </div>
  
  <script>
    function showQRCode() {
      // แสดง QR Code เมื่อคลิกที่ "QR Code"
      document.getElementById('qrCodeDetails').style.display = 'block';
      // ซ่อนข้อมูลธนาคาร
      document.getElementById('bankDetails').style.display = 'none';
    }
  
    function showBankDetails() {
      // แสดงข้อมูลธนาคารเมื่อคลิกที่ "ธนาคาร"
      document.getElementById('bankDetails').style.display = 'block';
      // ซ่อน QR Code
      document.getElementById('qrCodeDetails').style.display = 'none';
    }
    
  </script>
  
  
 {/block}