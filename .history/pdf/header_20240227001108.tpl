{**
 * Copyright since 2007 PrestaShop SA and Contributors
 * PrestaShop is an International Registered Trademark & Property of PrestaShop SA
 *
 * NOTICE OF LICENSE
 *
 * This source file is subject to the Open Software License (OSL 3.0)
 * that is bundled with this package in the file LICENSE.md.
 * It is also available through the world-wide-web at this URL:
 * https://opensource.org/licenses/OSL-3.0
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
 * @license   https://opensource.org/licenses/OSL-3.0 Open Software License (OSL 3.0)
 *}

<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>TAX INVOICE</title>
<style>
    body {
        font-family: Arial, sans-serif;
    }
    table {
        width: 100%;
        border-collapse: collapse;
    }
    td {
        padding: 10px;
        text-align: center;
    }
    .bold {
        font-weight: bold;
    }
    .large {
        font-size: 14pt;
    }
    .gray {
        color: #9E9F9E;
    }
</style>
</head>
<body>
<table>
    <tr>
        <td colspan="2" class="bold large">TAX INVOICE</td>
    </tr>
    <tr>
        <td style="width: 50%;">
            {if $logo_path}
                <img src="{$logo_path}" style="width:{$width_logo}px; height:{$height_logo}px;" />
            {/if}
        </td>
        <td style="width: 50%;">
            <table style="width: 100%">
                <tr>
                    <td class="gray large">{$date|escape:'html':'UTF-8'}</td>
                </tr>
                <tr>
                    <td class="gray large">{$title|escape:'html':'UTF-8'}</td>
                </tr>
            </table>
        </td>
    </tr>
</table>
</body>
</html>
