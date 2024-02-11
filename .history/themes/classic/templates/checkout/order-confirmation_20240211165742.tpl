{extends file='page.tpl'}

{block name='page_content_container' prepend}
    <section id="content-hook_order_confirmation" class="card">
      <div class="card-block">
        <div class="row">
          <div class="col-md-12">

            {block name='order_confirmation_header'}
              <h3 class="h1 card-title">
                <i class="material-icons rtl-no-flip done">&#xE876;</i>{l s='ทำการซื้อ Voucher สำเร็จ ขอบคุณที่สนับสนุน!🙏' d='Shop.Theme.Checkout'}
              </h3>
            {/block}
            {block name='hook_order_confirmation'}
              {$HOOK_ORDER_CONFIRMATION nofilter}
            {/block}

          </div>
        </div>
      </div>
    </section>
{/block}

{block name='page_content_container'}
  <section id="content" class="page-content page-order-confirmation card">
    <div class="card-block">
      <div class="row">

        {block name='order_confirmation_table'}
          {include
            file='checkout/_partials/order-confirmation-table.tpl'
            products=$order.products
            subtotals=$order.subtotals
            totals=$order.totals
            labels=$order.labels
            add_product_link=false
          }
        {/block}

        {block name='order_details'}
          <div id="order-details" class="col-md-4">
            <h3 class="h3 card-title">{l s='Order details' d='Shop.Theme.Checkout'}:</h3>
            <ul>
              <li id="order-reference-value">{l s='Order reference: %reference%' d='Shop.Theme.Checkout' sprintf=['%reference%' => $order.details.reference]}</li>
              <li>{l s='Payment method: %method%' d='Shop.Theme.Checkout' sprintf=['%method%' => $order.details.payment]}</li>
              {if !$order.details.is_virtual}

              {/if}
              {if $order.details.recyclable}
                <li>  
                  <em>{l s='You have given permission to receive your order in recycled packaging.' d="Shop.Theme.Customeraccount"}</em>
                </li>
              {/if}
            </ul>
          </div>
        {/block}

      </div>
    </div>
  </section>

  <!-- เพิ่มโค้ด Modal สำหรับการแนบหลักฐานการโอน -->
  <div class="modal fade" id="attachmentModal" tabindex="-1" role="dialog" aria-labelledby="attachmentModalLabel" aria-hidden="true">
    <div class="modal-dialog" role="document">
      <div class="modal-content">
        <div class="modal-header">
          <h5 class="modal-title" id="attachmentModalLabel">{l s='แนบหลักฐานการโอน' d='Shop.Theme.Actions'}</h5>
          <button type="button" class="close" data-dismiss="modal" aria-label="Close">
            <span aria-hidden="true">&times;</span>
          </button>
        </div>
        <div class="modal-body">
          <!-- เพิ่มฟอร์มอัพโหลดรูปภาพ -->
          <form action="{url entity='order' params=['ajax' => 1, 'action' => 'uploadTransferProof']}" method="post" enctype="multipart/form-data">
            <div class="form-group">
              <label for="transferProof">{l s='เลือกรูปภาพ' d='Shop.Theme.Actions'}</label>
              <input type="file" class="form-control-file" id="transferProof" name="transferProof" accept="image/*">
            </div>
            <button type="submit" class="btn btn-primary">{l s='Submit' d='Shop.Theme.Actions'}</button>
          </form>
          <!-- สิ้นสุดฟอร์ม -->
        </div>
        <div class="modal-footer">
          <button type="button" class="btn btn-secondary" data-dismiss="modal">{l s='Close' d='Shop.Theme.Actions'}</button>
        </div>
      </div>
    </div>
  </div>
  <!-- สิ้นสุดโค้ด Modal -->

  {block name='hook_payment_return'}
    {if ! empty($HOOK_PAYMENT_RETURN)}
    
    {/if}
  {/block}

  {if !$registered_customer_exists}
    {block name='account_transformation_form'}
      <div class="card">
        <div class="card-block">
          {include file='customer/_partials/account-transformation-form.tpl'}
        </div>
      </div>
    {/block}
  {/if}

  {block name='hook_order_confirmation_1'}
    {hook h='displayOrderConfirmation1'}
  {/block}

  {block name='hook_order_confirmation_2'}
    <section id="content-hook-order-confirmation-footer">
      {hook h='displayOrderConfirmation2'}
    </section>
  {/block}
{/block}
