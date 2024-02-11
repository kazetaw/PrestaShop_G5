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
          </form>
          <!-- เพิ่มฟอร์มหรือข้อมูลเพิ่มเติมตามที่คุณต้องการ -->
        </div>
        <div class="modal-footer">
     <!-- เพิ่มปุ่มหรือลิงค์ที่ต้องการให้ผู้ใช้ทำการจ่ายเงิน -->
          <div class="modal-body">
            <!-- เพิ่มฟอร์มอัพโหลดสลิป -->
            <form action="/upload_script.php" method="post" enctype="multipart/form-data">
              <div class="form-group">
                <label for="slipFile" class="col-sm-3 col-form-label">{l s='เลือกไฟล์สลิป:' d='Shop.Theme.Actions'}</label><br>
                <input type="file" class="form-control-file" id="slipFile" name="slipFile" accept=".png, .jpg" required>
              </div>
              <button type="submit" class="btn btn-primary">{l s='อัพโหลด' d='Shop.Theme.Actions'}</button>
            </form>
          </div>
        </div>
      </div>
    </div>
        </div>
      </div>
    </div>
  </div>
  <!-- JavaScript เพื่อแจ้งเตือนเมื่ออัพโหลดสลิปสำเร็จ -->
  <script>
    document.addEventListener('DOMContentLoaded', function () {
      const attachmentModal = new bootstrap.Modal(document.getElementById('attachmentModal'));
  
      // ฟังก์ชันที่เรียกเมื่ออัพโหลดสลิปสำเร็จ
      function handleUploadSuccess() {
        // ปิด Modal
        attachmentModal.hide();
        
        // แสดงข้อความแจ้งเตือนหรือดำเนินการเพิ่มเติมตามที่คุณต้องการ
        alert('ชำระเงินสำเร็จ! ขอบคุณที่อัพโหลดสลิปการโอนเงิน.');
    
        // เปลี่ยนหน้า
        window.location.href = '/new_page.html'; // แทนที่ '/new_page.html' ด้วย URL ที่คุณต้องการ
    }
    
      }
  
      // จำลองการเรียกใช้ handleUploadSuccess() เมื่ออัพโหลดสำเร็จ (ในทางปฏิบัติ คุณต้องเปลี่ยนแปลงฟังก์ชันนี้)
      const uploadForm = document.querySelector('#attachmentModal form');
      uploadForm.addEventListener('submit', function (event) {
        event.preventDefault();
  
        // สำหรับการจำลอง ให้เรียกใช้ handleUploadSuccess() หลังจากเสร็จสิ้นการอัพโหลด
        setTimeout(handleUploadSuccess, 2000);
      });
   
      // เพิ่มโค้ดที่จะทำงานเมื่อ Modal ถูกปิด
        attachmentModal._element.addEventListener('hidden.bs.modal', function () {
        // เพิ่มโค้ดที่ต้องการทำหลังจาก Modal ถูกปิด
      });
    });
  </script>
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

 {/block}