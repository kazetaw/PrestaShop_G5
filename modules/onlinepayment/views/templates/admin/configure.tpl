<form method="post">
    <div class="panel">
        <div class="panel-heading">
            {l s='Online Payment Configuration' mod='onlinepayment'}
        </div>
        <div class="panel-body">
            <label for="promptpay-size">{l s='Promptpay QR Code size'}</label>
            <input type="number" min="4" max="16" id="promptpay-size" name="promptpay-size" value="{$PROMPTPAY_SIZE}" />
            <label for="promptpay-id">{l s='Promptpay ID'}</label>
            <input type="text" maxlength="13" id="promptpay-id" name="promptpay-id" value="{$PROMPTPAY_ID}" />
        </div>
        <div class="panel-footer">
            <button type="submit" name="saveonlinepayment" class="btn btn-default pull-right">
                {l s='Save' mod='onlinepayment'}
            </button>
        </div>
    </div>
</form>