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
   
   {extends file='page.tpl'}
   
   {block name='page_content'}
     <div class="container">
       <h1>{l s='Payment Page' d='Shop.Theme.Actions'}</h1>
   
       <form id="paymentForm" action="#" method="post">
         <label for="cardNumber">{l s='Card Number' d='Shop.Theme.Actions'}:</label>
         <input type="text" id="cardNumber" name="cardNumber" placeholder="{l s='Card Number' d='Shop.Theme.Actions'}" required>
         <br>
   
         <label for="expiryDate">{l s='Expiry Date' d='Shop.Theme.Actions'}:</label>
         <input type="text" id="expiryDate" name="expiryDate" placeholder="{l s='MM/YY' d='Shop.Theme.Actions'}" required>
         <br>
   
         <label for="cvv">{l s='CVV' d='Shop.Theme.Actions'}:</label>
         <input type="text" id="cvv" name="cvv" placeholder="{l s='CVV' d='Shop.Theme.Actions'}" required>
         <br>
   
         <label for="amount">{l s='Amount' d='Shop.Theme.Actions'}:</label>
         <input type="text" id="amount" name="amount" placeholder="{l s='Amount' d='Shop.Theme.Actions'}" required>
         <br>
   
         <button type="button" onclick="submitPayment()">{l s='Submit Payment' d='Shop.Theme.Actions'}</button>
       </form>
   
       <script>
         function submitPayment() {
           // Validate and process payment (replace with your actual payment processing logic)
           var cardNumber = document.getElementById('cardNumber').value;
           var expiryDate = document.getElementById('expiryDate').value;
           var cvv = document.getElementById('cvv').value;
           var amount = document.getElementById('amount').value;
   
           // Simulate payment processing (replace with actual API call to payment gateway)
           alert('{l s='Payment processed successfully!' d='Shop.Theme.Actions'}\n{ldelim}Card Number: ' + cardNumber + '\nAmount: ' + amount + '{rdelim}');
   
           // Redirect to a thank you page or any other relevant page
           window.location.href = '{url entity='order' controller='order-confirmation' params=[('id_order', $cart.id)]}';
         }
       </script>
     </div>
   {/block}
   