{if $stripe_activated}
    <div class="payment-option qrcode-payment">
        <div class="custom-radio">
            <input type="radio" id="payment_option_qrcode" name="payment_option" class="ps-shown-by-js">
            <label for="payment_option_qrcode" class="d-flex align-items-center">
                <span class="radio-label">
                    {$module.qrcodepayment}
                </span>
                <img src="{$module_url}logo.png" alt="QR Code Logo" class="logo">
            </label>
        </div>
    </div>
{/if}
