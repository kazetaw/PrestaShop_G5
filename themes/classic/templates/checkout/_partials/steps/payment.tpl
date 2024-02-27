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
            {* This is the way an option should be selected when Javascript is enabled *}
            <span class="custom-radio float-xs-left">
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

        {if $option.additionalInformation}
          <div
            id="{$option.id}-additional-information"
            class="js-additional-information definition-list additional-information{if $option.id != $selected_payment_option} ps-hidden {/if}"
          >
            {$option.additionalInformation nofilter}
          </div>
        {/if}

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
  <div class="modal-body">
    <!-- เพิ่มฟอร์มอัพโหลดสลิป -->
    <form method="post"action="http://localhost:8080/en/order-confirmation?id_cart=66&id_module=27&id_order=56&key=abf13a7968f4a5c64810f10d52605de8" onsubmit="showAlert()">
      <div class="form-group">
          <input type="file" class="form-control-file" id="slipFile" name="slipFile" accept=".png, .jpg" required>
      </div>
  </form>          
</div>
  <div id="payment-confirmation" class="js-payment-confirmation">
    <div class="ps-shown-by-js">
      <button type="button" class="btn btn-primary center-block{if !$selected_payment_option} disabled{/if}" onclick="handlePlaceOrder()">
        {l s='Place order' d='Shop.Theme.Checkout'}
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
  <div class="modal-footer">
    <!-- เพิ่มปุ่มหรือลิงค์ที่ต้องการให้ผู้ใช้ทำการจ่ายเงิน -->
             <div class="form-group">
             </div>
         </form>          
       </div>
     </div>
   </div>
   
       </div>
     </div>
   </div>
 </div>
 <script src="https://cdn.jsdelivr.net/npm/sweetalert2@10"></script>

 <script>
     function showAlert() {
         Swal.fire({
             title: "Payment successful!",
             text: "Thank you for your support.",
             icon: "success"
         });
 
         // รอ 2 วินาที (2000 milliseconds) ก่อนที่จะส่งข้อมูลแบบฟอร์ม
         setTimeout(function () {
             document.getElementById('yourFormId').submit();
         }, 2000);
     }
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
             Swal.fire({
               icon: "error",
               title: "Oops...",
               text: "Not Slip Try again!",
             });
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
  // JavaScript function to handle the slip upload and form submission
  function handlePlaceOrder() {
      // Perform slip upload logic here

      // Example: Display a confirmation alert
      showAlert();

      // Example: Simulate form submission after a delay (adjust as needed)
      setTimeout(function () {
          document.getElementById('yourFormId').submit();
      }, 2000);
  }

  function showAlert() {
      Swal.fire({
          title: "Payment successful!",
          text: "Thank you for your support.",
          icon: "success"
      });
  }
</script>
{/block}
