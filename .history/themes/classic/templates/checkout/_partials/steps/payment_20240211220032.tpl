{extends file='checkout/_partials/steps/checkout-step.tpl'}

{block name='step_content'}

 {hook h='displayPaymentTop'}

 <div class="form-group">
  <label for="slipFile" class="col-sm-3 col-form-label">{l s='เลือกไฟล์สลิป:' d='Shop.Theme.Actions'}</label><br>
  <input type="file" class="form-control-file" id="slipFile" name="slipFile" accept=".png, .jpg" required>
 </div>
  
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
    
