/*import { test, expect } from '@playwright/test';

test('test', async ({ page }) => {
  await page.goto('http://localhost:8080/en/');
  await page.getByRole('link', { name: 'Vocher 500' }).first().click();
  await page.getByRole('button', { name: ' Add to cart' }).click();
  await page.getByRole('link', { name: ' Proceed to checkout' }).click();
  await page.getByRole('link', { name: 'ออกใบกำกับภาษี' }).click();
  await page.getByText('Mrs.').click();
  await page.getByLabel('First name').click();
  await page.getByLabel('First name').fill('Tawn');
  await page.getByLabel('Last name').click();
  await page.getByLabel('Last name').fill('Fawww');
  await page.getByLabel('Email').click();
  await page.getByLabel('Email').fill('Gfff9855@gmail.com');
  await page.getByPlaceholder('MM/DD/YYYY').click();
  await page.getByLabel('\n              Receive offers from our partners').check();
  await page.getByText(' Sign up for our').click();
  await page.getByText('Social title Mr. Mrs. First').click();
  await page.getByText(' I agree to the terms and').click();
  await page.getByText(' Receive offers from our').click();
  await page.getByText(' Customer data privacyThe').click();
  await page.getByRole('button', { name: 'Continue' }).click();
  await page.getByLabel('Address', { exact: true }).click();
  await page.getByLabel('Address', { exact: true }).fill('98/88');
  await page.getByLabel('City').click();
  await page.getByLabel('City').fill('ffaf');
  await page.getByLabel('State').selectOption('6');
  await page.getByLabel('Zip/Postal Code').click();
  await page.getByLabel('Zip/Postal Code').fill('988888');
  await page.getByRole('button', { name: 'Continue' }).click();
  await page.getByLabel('Zip/Postal Code').click();
  await page.getByLabel('Zip/Postal Code').fill('98888');
  await page.getByRole('button', { name: 'Continue' }).click();
  await page.getByRole('button', { name: 'Continue' }).click();
  await page.getByLabel('I agree to the terms of').check();
  await page.getByRole('button', { name: 'Place order' }).click();
  await page.getByText('Vocher 500 ฿500.00 1 ฿').click();
});