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
 {block name="address_form"}
   <div class="js-address-form" >
     {include file='_partials/form-errors.tpl' errors=$errors['']}
 
     <input type="checkbox" id="xneedinvoice"> Show/Hide Form
 
     {block name="address_form_url"}
     <form
       method="POST"
       action="{url entity='address' params=['id_address' => $id_address]}"
       data-id-address="{$id_address}"
       data-refresh-url="{url entity='address' params=['ajax' => 1, 'action' => 'addressForm']}"
       style="display: none;"
     >
     {/block}
     
    
    <div id="xformContainer">
       {block name="address_form_fields"}
         <section class="form-fields">
           {block name='form_fields'}
             {foreach from=$formFields item="field"}
               {block name='form_field'}
                 {form_field field=$field}
               {/block}
             {/foreach}
           {/block}
         </section>
       {/block}
    </div> 
       {block name="address_form_footer"}
       <footer class="form-footer clearfix">
         <input type="hidden" name="submitAddress" value="1">
         {block name='form_buttons'}
           <button class="btn btn-primary form-control-submit float-xs-right" id = "bt2" type="submit">
             {l s='Save' d='Shop.Theme.Actions'}
           </button>
         {/block}
       </footer>
       {/block}
 
     </form>
   </div>
 
   

   <script>
    document.addEventListener("DOMContentLoaded", function() {
      var checkbox = document.getElementById("xneedinvoice");
      var form = document.getElementById("xformContainer");
      var f1 = document.querySelector('input[name="firstname"]');
      var l1 = document.querySelector('input[name="lastname"]');
      var ad1 = document.querySelector('input[name="address1"]');
      var ad2 = document.querySelector('input[name="address2"]');
      var pp1 = document.querySelector('input[name="postcode"]');
      var c1 = document.querySelector('input[name="city"]');
      var ph1 = document.querySelector('input[name="phone"]');
      var vat1 = document.querySelector('input[name="vat_number"]');
      

      console.log("hee2")
      // Hide the form initially
      form.style.display = "none";
      console.log("hee2")
      f1.value = "quest";
      l1.value = "quest";
      ad1.value = "quest";
      ad2.value = "quest";
      pp1.value = "00000";
      c1.value = "quest";
      ph1.value = "099999999";
      vat1.value = "1111111111111";
  
      // Add event listener to the checkbox
      checkbox.addEventListener("change", function() {
          if (checkbox.checked) {
              // If checkbox is checked, show the form
              form.style.display = "block";
              f1.value = "";
              l1.value = "";
              ad1.value = "";
              ad2.value = "";
              pp1.value = "";
              c1.value = "";
              ph1.value = "";
              vat1.value = "";

          } else {
              // If checkbox is unchecked, hide the form
              form.style.display = "none";
              f1.value = "quest";
              l1.value = "quest";
              ad1.value = "quest";
              ad2.value = "quest";
              pp1.value = "00000";
              c1.value = "quest";
              ph1.value = "099999999";
              vat1.value = "1111111111111";
          }
      });
  });
  
  </script>
 {/block}
 