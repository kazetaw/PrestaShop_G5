{**
 * 2007-2020 PrestaShop and Contributors
 *
 * NOTICE OF LICENSE
 *
 * This source file is subject to the Academic Free License 3.0 (AFL-3.0)
 * that is bundled with this package in the file LICENSE.txt.
 * It is also available through the world-wide-web at this URL:
 * https://opensource.org/licenses/AFL-3.0
 * If you did not receive a copy of the license and are unable to
 * obtain it through the world-wide-web, please send an email
 * to license@prestashop.com so we can send you a copy immediately.
 *
 * @author    PrestaShop SA <contact@prestashop.com>
 * @copyright 2007-2020 PrestaShop SA and Contributors
 * @license   https://opensource.org/licenses/AFL-3.0 Academic Free License 3.0 (AFL-3.0)
 * International Registered Trademark & Property of PrestaShop SA
 *}

<section>
  <p>
    {l s='Scan QR to transfer into account' d='Modules.Wirepayment.Shop'} <br><br>
    <img src="\themes\classic\templates\checkout\_partials\steps\qr\promptpay.png" alt="service" style="width:100px;height:100px;">
        <br>
    {if $bankwireReservationDays}
      {l s='Goods will be reserved %s days for you and we\'ll process the order immediately after receiving the payment.' sprintf=[$bankwireReservationDays] d='Modules.Wirepayment.Shop'}
    {/if}
    {if $bankwireCustomText }
        <a data-toggle="modal" data-target="#bankwire-modal">{l s='More information' d='Modules.Wirepayment.Shop'}</a>
    {/if}
  </p>

  <div class="modal fade" id="bankwire-modal" tabindex="-1" role="dialog" aria-labelledby="Bankwire information" aria-hidden="true">
    <div class="modal-dialog" role="document">
      <div class="modal-content">
        <div class="modal-header">
          <button type="button" class="close" data-dismiss="modal" aria-label="Close">
            <span aria-hidden="true">&times;</span>
          </button>
          <h2>{l s='Bankwire' d='Modules.Wirepayment.Shop'}</h2>
        </div>
        <div class="modal-body">
          <p>{l s='Payment is made by transfer of the invoice amount to the following account:' d='Modules.Wirepayment.Shop'}</p>
          {include file='module:ps_qrpayment/views/templates/hook/_partials/payment_infos.tpl'}
          {$bankwireCustomText nofilter}
        </div>
      </div>
    </div>
  </div>
</section>
