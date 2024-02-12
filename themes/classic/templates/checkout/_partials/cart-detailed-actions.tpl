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

{literal}
<script src="https://cdn.jsdelivr.net/npm/tesseract.js@2.1.1"></script>
<script>
document.addEventListener('DOMContentLoaded', function () {
    const form = document.getElementById('uploadForm');
    form.addEventListener('submit', function(event) {
        event.preventDefault();

        const fileInput = document.getElementById('slipFile');
        const file = fileInput.files[0];
        if (!file) {
            alert('กรุณาเลือกไฟล์ก่อน!');
            return;
        }

        const reader = new FileReader();
        reader.onload = function(e) {
            const img = new Image();
            img.onload = function() {
                const canvas = document.createElement('canvas');
                const ctx = canvas.getContext('2d');
                canvas.width = img.width;
                canvas.height = img.height;
                ctx.drawImage(img, 0, 0);
                const imageData = ctx.getImageData(0, 0, canvas.width, canvas.height);
                if (!isImageMostlyWhite(imageData)) {
                    // Image passed the white space check, now use Tesseract.js for OCR
                    performOCR(file);
                } else {
                    alert('The image seems to be blank or does not contain enough text.');
                }
            };
            img.src = e.target.result;
        };
        reader.readAsDataURL(file);
    });
});

function isImageMostlyWhite(imageData) {
    let whitePixels = 0;
    for (let i = 0; i < imageData.data.length; i += 4) {
        if (imageData.data[i] > 200 && imageData.data[i+1] > 200 && imageData.data[i+2] > 200) whitePixels++;
    }
    return whitePixels > (imageData.data.length / 4) * 0.9; // Adjust threshold as needed
}

function performOCR(file) {
    Tesseract.recognize(
        file,
        'tha', // Or 'eng' for English
        { logger: m => console.log(m) }
    ).then(({ data: { text } }) => {
        if (text.trim().length > 0) {
            // window.location.href = 'http://localhost:8080/upload_script.php'; // Success
            aleat('สำเร็จ');
        } else {
            alert('ไม่พบข้อความภาษาไทยในไฟล์, กรุณาอัพโหลดไฟล์ที่ถูกต้อง');
        }
    }).catch(error => {
        console.error(error);
        alert('เกิดข้อผิดพลาดในการประมวลผลภาพ');
    });
}
</script>
{/literal}

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
  <!-- Modal สำหรับอัพโหลดสลิป -->
 
  <!-- Modal สำหรับจ่ายเงิน -->
  <div class="modal fade" id="paymentModal" tabindex="-1" role="dialog" aria-labelledby="paymentModalLabel" aria-hidden="true">
    <div class="modal-dialog" role="document">
      <div class="modal-content">
        <div class="modal-header">
          <h5 class="modal-title" id="paymentModalLabel">{l s='Payment Options' d='Shop.Theme.Actions'}</h5>
          <button type="button" class="close" data-dismiss="modal" aria-label="Close">
            <span aria-hidden="true">&times;</span>
          </button>
          <div class="cart-summary-products js-cart-summary-products">
  <p>{$cart.summary_string}</p>

  <p>
    <a href="#" data-toggle="collapse" data-target="#cart-summary-product-list" class="js-show-details">
      {l s='show details' d='Shop.Theme.Actions'}
      <i class="material-icons">expand_more</i>
    </a>
  </p>

  {block name='cart_summary_product_list'}
    <div class="collapse" id="cart-summary-product-list">
      <ul class="media-list">
        {foreach from=$cart.products item=product}
          <li class="media">{include file='checkout/_partials/cart-summary-product-line.tpl' product=$product}</li>
        {/foreach}
      </ul>
    </div>
  {/block}
</div>
        </div>
        <div class="modal-body">
          <!-- เพิ่มฟอร์มหรือข้อมูลที่เกี่ยวข้องกับการจ่ายเงินที่นี่ -->
          <p>{l s='ขั้นตอนการจ่ายเงิน' d='Shop.Theme.Actions'}</p>
          <form action="/action_page.php">
            <p>เลือกช่องทางการชำระเงิน:</p>
            <input type="radio" id="html" name="fav_language" value="Bank" onclick="showBankDetails()" style="display: inline-block; margin-right: 5px;">
            <label for="html" style="display: inline-block; margin-right: 15px;">ธนาคาร</label>
            <input type="radio" id="css" name="fav_language" value="QR" onclick="showQRCode()" style="display: inline-block; margin-right: 5px;">
            <label for="css" style="display: inline-block; margin-right: 15px;">QR Code</label>
            <input type="radio" id="javascript" name="fav_language" value="Promtpay" onclick="showPromptpayDetails()" style="display: inline-block;">
            <label for="javascript" style="display: inline-block;">Promtpay</label>
            <input type="radio" id="counterService" name="fav_language" value="CounterService" onclick="showCounterServiceDetails()" style="display: inline-block;">
            <label for="counterService" style="display: inline-block;">Counter Service</label>
            
            <div id="CounterServiceDetails" style="display:none;">
              <p>{l s='โชว์เคาท์เตอร์เซอร์วิสที่นี่' d='Shop.Theme.Actions'}</p>
              <div class="cart-overview js-cart" data-refresh-url="{url entity='cart' params=['ajax' => true, 'action' => 'refresh']}">
                {if $cart.products}
                <ul class="cart-items">
                  {foreach from=$cart.products item=product}
                    <li class="cart-item">
                      {block name='cart_detailed_product_line'}
                        {include file='checkout/_partials/cart-detailed-product-line.tpl' product=$product}
                      {/block}
                    </li>
                    {if is_array($product.customizations) && $product.customizations|count >1}<hr>{/if}
                  {/foreach}
                </ul>
                {else}
                  <span class="no-items">{l s='There are no more items in your cart' d='Shop.Theme.Checkout'}</span>
                {/if}
                <img src="https://cdn.shopify.com/shopifycloud/help/assets/manual/sell-in-person/hardware/barcode-scanner/1d-barcode-4fbf513f48675746ba39d9ea5078f377e5e1bb9de2966336088af8394b893b78.png" alt="service" style="width:425px;height:100px;"><br>
                <img src="https://www.sosthailand.org/getmedia/1094cc58-3ae4-49df-a9dd-5cb345847d50/Counter-Service-7-Eleven-logo.png?width=570&height=365&ext=.png" alt="service-logo" style="width:67px;height:46px;">
                    <br>
              </div>
            </div>

            <!-- แสดงข้อมูลของธนาคารเมื่อคลิกที่ "ธนาคาร" -->
            <div id="bankDetails" style="display:none;">
              <p>{l s='Bank details: Kbank 0448447561 มหาวิทยาลัยขอนแก่น' d='Shop.Theme.Actions'}</p>
            </div>
            <!-- แสดงข้อมูลของ QR Code เมื่อคลิกที่ "QR Code" -->
            <div id="qrCodeDetails" style="display:none; text-align: center;">
              <img src="https://th.bing.com/th/id/OIP.HHacbpUBSuYqZfXIWFn-IQHaHa?rs=1&pid=ImgDetMain" alt="QR Code Logo" style="width: 100px; border: 1px solid #ccc; padding: 5px;">
            </div>
            <!-- แสดงข้อมูลของพร้อมเพย์มื่อคลิกที่ "Promtpay" -->
            <div id="promtpayDetails" style="display:none;">
              <p>{l s='Promtpay: 0221115554 มหาวิทยาลัยขอนแก่น' d='Shop.Theme.Actions'}</p>
            </div>

            <div id="CounterServiceDetails" style="display:none;">
              <p>{l s='กรุณาดาวน์โหลดหลักฐานการชำระเงินและชำระเงินที่เคาน์เตอร์เซอร์วิสทุกสาขา' d='Shop.Theme.Actions'}</p>
            <!-- This link should point to the PDF or file generated for payment. Adjust the href attribute accordingly. -->
            <a href="/path/to/counter_service_payment_slip.pdf" download="{l s='Payment Slip' d='Shop.Theme.Actions'}">{l s='Download Payment Slip' d='Shop.Theme.Actions'}</a>
            </div>
            

          </form>
          <!-- เพิ่มฟอร์มหรือข้อมูลเพิ่มเติมตามที่คุณต้องการ -->
        </div>
        <div class="modal-footer">
     <!-- เพิ่มปุ่มหรือลิงค์ที่ต้องการให้ผู้ใช้ทำการจ่ายเงิน -->
          <div class="modal-body">
            <!-- เพิ่มฟอร์มอัพโหลดสลิป -->
            <form method="post" enctype="multipart/form-data">
              <div class="form-group">
                <input action="" type="file" class="form-control-file" id="slipFile" name="slipFile" accept=".png, .jpg" required>
              </div>
              <button type="submit" class="btn btn-primary">อัพโหลด</button>
            </form>
          </div>
        </div>
      </div>
    </div>
    
        </div>
      </div>
    </div>
  </div>
  
<script src="https://cdn.jsdelivr.net/npm/jsqr/dist/jsQR.js"></script>
<script>
  document.getElementById('slipFile').addEventListener('change', function() {
    var file = this.files[0];
    if (file) {
      var fileName = file.name;
      var fileType = fileName.substring(fileName.lastIndexOf('.') + 1).toLowerCase();
      if (fileType === 'jpg' || fileType === 'png') {
        var reader = new FileReader();
        reader.onload = function(event) {
          var img = new Image();
          img.onload = function() {
            var canvas = document.createElement('canvas');
            var context = canvas.getContext('2d');
            canvas.width = img.width;
            canvas.height = img.height;
            context.drawImage(img, 0, 0);
            var imageData = context.getImageData(0, 0, canvas.width, canvas.height);
            
            // ใช้ jsQR เพื่อแยก QR code ออกมา
            var code = jsQR(imageData.data, imageData.width, imageData.height);
            
            if (code) {
              // กระทำเพิ่มเติมเมื่อพบ QR code
            } else {
              alert('ไม่ใช่สลิป กรุณาอัพโหลดใหม่อีกครั้ง');
              document.getElementById('slipFile').value = "";
              // กระทำเพิ่มเติมเมื่อไม่พบ QR code
            }
          };
          img.src = event.target.result;
        };
        reader.readAsDataURL(file);
      } else {
        alert("ไฟล์ที่เลือกต้องเป็นรูปภาพเท่านั้น (.jpg หรือ .png)");
        document.getElementById('slipFile').value = "";
      }
    }
  });
</script>
<script>
  function showQRCode() {
    // แสดง QR Code เมื่อคลิกที่ "QR Code"
    document.getElementById('qrCodeDetails').style.display = 'block';
    // ซ่อนข้อมูลธนาคาร
    document.getElementById('promtpayDetails').style.display = 'none';
    
    document.getElementById('bankDetails').style.display = 'none';
    document.getElementById('CounterServiceDetails').style.display = 'none';
  }

  function showBankDetails() {
    // แสดงข้อมูลธนาคารเมื่อคลิกที่ "ธนาคาร"
    document.getElementById('bankDetails').style.display = 'block';
    // ซ่อน QR Code
    document.getElementById('qrCodeDetails').style.display = 'none';
    //ซ่อน Promtpay
    document.getElementById('promtpayDetails').style.display = 'none';
    document.getElementById('CounterServiceDetails').style.display = 'none';
  }
  function showPromptpayDetails() {
    // แสดงข้อมูลพร้อมเพย์เมื่อคลิกที่ "Promtpay"
    document.getElementById('promtpayDetails').style.display = 'block';
    // ซ่อน QR Code
    document.getElementById('qrCodeDetails',bankDetails).style.display = 'none';
    // ซ่อนข้อมูลธนาคาร
    document.getElementById('CounterServiceDetails').style.display = 'none';
  
  }
  function showCounterServiceDetails() {
    // Hide other payment details
    document.getElementById('promtpayDetails').style.display = 'none';
    document.getElementById('qrCodeDetails').style.display = 'none';
    document.getElementById('bankDetails').style.display = 'none';
    // Show Counter Service details
    document.getElementById('CounterServiceDetails').style.display = 'block';
  }
  function showCounterServiceDetails() {
    // แสดงข้อมูลเมื่อคลิกที่ "CounterService"
    document.getElementById('CounterServiceDetails').style.display = 'block';
    
    // ซ่อน QR Code
    document.getElementById('qrCodeDetails').style.display = 'none';
    
    // ซ่อนข้อมูลธนาคาร
    document.getElementById('bankDetails').style.display = 'none';
    
    // ซ่อนข้อมูลพร้อมเพย์
    document.getElementById('promtpayDetails').style.display = 'none';
}
</script>

 {/block}