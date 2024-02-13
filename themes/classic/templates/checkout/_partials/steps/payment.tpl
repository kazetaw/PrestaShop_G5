{extends file='checkout/_partials/steps/checkout-step.tpl'}

{block name='step_content'}

  {hook h='displayPaymentTop'}


  
  {* used by javascript to correctly handle cart updates when we are on payment step (eg vouchers added) *}
  <div style="display:none" class="js-cart-payment-step-refresh"></div>

  {if !empty($display_transaction_updated_info)}
  <p class="cart-payment-step-refreshed-info">
    {l s='Transaction amount has been correctly updated' d='Shop.Theme.Checkout'}
  </p>
  {/if}

  {if $is_free}
    <p class="cart-payment-step-not-needed-info">{l s='No payment needed for this order' d='Shop.Theme.Checkout'}</p>
  {/if}
  <div class="payment-options {if $is_free}hidden-xs-up{/if}">
    {foreach from=$payment_options item="module_options"}
      {foreach from=$module_options item="option"}
        <div>
          <div id="{$option.id}-container" class="payment-option clearfix">
            <label for="html" style="display: inline-block; margin-right: 15px; background-color: #9999FF; color: white; padding: 5px;">ช่องทางการชำระเงิน</label>
            {* This is the way an option should be selected when Javascript is enabled *}
            <span class="custom-radio float-xs-left"> <br>
              <input
                class="ps-shown-by-js {if $option.binary} binary {/if}"
                id="{$option.id}"
                data-module-name="{$option.module_name}"
                name="payment-option"
                type="radio"
                required 
                
                {if ($selected_payment_option == $option.id || $is_free) || ($payment_options|@count === 1 && $module_options|@count === 1)} checked {/if}
              >
                
              <span></span>
            </span>
            <br>
            {* This is the way an option should be selected when Javascript is disabled *}
            
            <form method="GET" class="ps-hidden-by-js">
              {if $option.id === $selected_payment_option}
                {l s='Selected' d='Shop.Theme.Checkout'}
              {else}
                <button class="ps-hidden-by-js" type="submit" name="select_payment_option" value="{$option.id}">
                  {l s='Choose' d='Shop.Theme.Actions'}
                </button>
              {/if}
            </form>
            <label for="{$option.id}">
              <span>{$option.call_to_action_text}</span>
              
              {if $option.logo}
                <img src="{$option.logo}" loading="lazy">
              {/if}
            </label>

          </div>
        </div>
        <!-- เพิ่มฟอร์มหรือข้อมูลที่เกี่ยวข้องกับการจ่ายเงินที่นี่ -->
          <input class="custom-radio float-xs-left" type="radio" id="html" name="fav_language" value="Bank" onclick="showBankDetails()" style="display: inline-block; margin-right: 5px;">
          <label for="html" style="display: inline-block; margin-right: 15px;">ธนาคาร</label> <br>
          <input class="custom-radio float-xs-left" type="radio" id="css" name="fav_language" value="QR" onclick="showQRCode()" style="display: inline-block; margin-right: 5px;">
          <label for="css" style="display: inline-block; margin-right: 15px;">QR Code</label> <br>
          <input class="custom-radio float-xs-left" type="radio" id="javascript" name="fav_language" value="Promtpay" onclick="showPromptpayDetails()" style="display: inline-block;">
          <label for="javascript" style="display: inline-block;">Promtpay</label> <br>
          <input class="custom-radio float-xs-left" type="radio" id="javascript" name="fav_language" value="CounterService" onclick="showCounterServiceDetails()" style="display: inline-block;">
          <label for="javascript" style="display: inline-block;">เคาท์เตอร์เซอร์วิส</label>

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
          <!-- แสดงข้อมูลของพร้อมเพย์มื่อคลิกที่ "CounterService" -->

          <div id="CounterServiceDetails" style="display:none;">
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
        </form>
        <!-- เพิ่มฟอร์มหรือข้อมูลเพิ่มเติมตามที่คุณต้องการ -->
      </div>
    <script>
      function showQRCode() {
        // แสดง QR Code เมื่อคลิกที่ "QR Code"
        document.getElementById('qrCodeDetails').style.display = 'block';
        // ซ่อนข้อมูลธนาคาร
        document.getElementById('promtpayDetails').style.display = 'none';
  
        document.getElementById('bankDetails').style.display = 'none';
        document.getElementById('CounterService').style.display = 'none';

      }
    
      function showBankDetails() {
        // แสดงข้อมูลธนาคารเมื่อคลิกที่ "ธนาคาร"
        document.getElementById('bankDetails').style.display = 'block';
        // ซ่อน QR Code
        document.getElementById('qrCodeDetails').style.display = 'none';
        //ซ่อน Promtpay
        document.getElementById('promtpayDetails').style.display = 'none';
        document.getElementById('CounterService').style.display = 'none';

      }
      function showPromptpayDetails() {
        // แสดงข้อมูลพร้อมเพย์เมื่อคลิกที่ "Promtpay"
        document.getElementById('promtpayDetails').style.display = 'block';
        // ซ่อน QR Code
        document.getElementById('qrCodeDetails',bankDetails).style.display = 'none';
        // ซ่อนข้อมูลธนาคาร
        document.getElementById('CounterService').style.display = 'none';

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
        

        <div
          id="pay-with-{$option.id}-form"
          class="js-payment-option-form {if $option.id != $selected_payment_option} ps-hidden {/if}"
        >
          {if $option.form}
            {$option.form nofilter}
          {else}
            <form id="payment-{$option.id}-form" method="POST" action="{$option.action nofilter}">
              {foreach from=$option.inputs item=input}
                <input type="{$input.type}" name="{$input.name}" value="{$input.value}">
              {/foreach}
              <button style="display:none" id="pay-with-{$option.id}" type="submit"></button>
            </form>
          {/if}
        </div>
      {/foreach}
    {foreachelse}
      <p class="alert alert-danger">{l s='Unfortunately, there are no payment method available.' d='Shop.Theme.Checkout'}</p>
    {/foreach}
  </div>

  {if $conditions_to_approve|count}
    <p class="ps-hidden-by-js">
      {* At the moment, we're not showing the checkboxes when JS is disabled
         because it makes ensuring they were checked very tricky and overcomplicates
         the template. Might change later.
      *}
      {l s='By confirming the order, you certify that you have read and agree with all of the conditions below:' d='Shop.Theme.Checkout'}
    </p>

    <form id="conditions-to-approve" class="js-conditions-to-approve" method="GET">
      <ul>
        {foreach from=$conditions_to_approve item="condition" key="condition_name"}
          <li>
            <div class="float-xs-left">
              <span class="custom-checkbox">
                <input  id    = "conditions_to_approve[{$condition_name}]"
                        name  = "conditions_to_approve[{$condition_name}]"
                        required
                        type  = "checkbox"
                        value = "1"
                        class = "ps-shown-by-js"
                >
                <span><i class="material-icons rtl-no-flip checkbox-checked">&#xE5CA;</i></span>
              </span>
            </div>
            <div class="condition-label">
              <label class="js-terms" for="conditions_to_approve[{$condition_name}]">
                {$condition nofilter}
              </label>
            </div>
          </li>
        {/foreach}
      </ul>
    </form>
  {/if}

  {hook h='displayCheckoutBeforeConfirmation'}

  {if $show_final_summary}
    {include file='checkout/_partials/order-final-summary.tpl'}
  {/if}
  <div class="form-group">
    <label for="slipFile" class="col-sm-3 col-form-label">{l s='' d='Shop.Theme.Actions'}</label><br>
    <input type="file" class="form-control-file" id="slipFile" name="slipFile" accept=".png, .jpg" required>
  </div>
  
  <div id="payment-confirmation" class="js-payment-confirmation">
    <div class="ps-shown-by-js">
      <button type="submit" class="btn btn-primary center-block{if !$selected_payment_option} disabled{/if}">
        {l s='อัพโหลดสลิป' d='Shop.Theme.Checkout'}
      </button>
      {if $show_final_summary}
        <article class="alert alert-danger mt-2 js-alert-payment-conditions" role="alert" data-alert="danger">
          {l
            s='Please make sure you\'ve chosen a [1]payment method[/1] and accepted the [2]terms and conditions[/2].'
            sprintf=[
              '[1]' => '<a href="#checkout-payment-step">',
              '[/1]' => '</a>',
              '[2]' => '<a href="#conditions-to-approve">',
              '[/2]' => '</a>'
            ]
            d='Shop.Theme.Checkout'
          }
        </article>
      {/if}
    </div>
    <div class="ps-hidden-by-js">
      {if $selected_payment_option and $all_conditions_approved}
        <label for="pay-with-{$selected_payment_option}">{l s='Order with an obligation to pay' d='Shop.Theme.Checkout'}</label>
      {/if}
    </div>
  </div>
  
  {hook h='displayPaymentByBinaries'}

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
