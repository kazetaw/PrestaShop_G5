<!DOCTYPE html>
<html lang="th">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>ใบแจ้งการชำระเงิน</title>
  <style>
    body {
      font-family: Arial, sans-serif;
      margin: 0;
      padding: 0;
    }

    .container {
      width: 800px;
      margin: 0 auto;
    }

    .header {
      text-align: center;
      margin-top: 20px;
    }

    .header img {
      width: 150px;
    }

    .title {
      font-size: 24px;
      font-weight: bold;
    }

    .info {
      margin-top: 20px;
    }

    .info-left {
      float: left;
      width: 400px;
    }

    .info-right {
      float: right;
      width: 400px;
    }

    .info-row {
      margin-bottom: 10px;
    }

    .label {
      font-weight: bold;
    }

    .value {
      margin-left: 10px;
    }

    .table {
      margin-top: 20px;
      width: 100%;
      border-collapse: collapse;
    }

    .table th, .table td {
      border: 1px solid black;
      padding: 5px;
    }

    .table th {
      text-align: center;
    }

    .barcode {
      margin-top: 20px;
      text-align: center;
    }

    .barcode canvas {
      width: 150px;
      height: 60px;
    }

    .footer {
      text-align: center;
      margin-top: 20px;
    }
  </style>
  <!-- Include JsBarcode library -->
  <script src="https://cdn.jsdelivr.net/npm/jsbarcode@3.11.0/dist/JsBarcode.all.min.js"></script>
</head>
<body>
  <div class="container">
    <div class="header">
      <img src="https://www.gump.in.th/logo.png" alt="Logo">
      <h1 class="title">ใบแจ้งการชำระเงิน</h1>
    </div>
    <div class="info">
      <div class="info-left">
        <div class="info-row">
          <span class="label">บริษัท:</span>
          <span class="value">บริษัท เคาน์เตอร์เซอร์วิส จํากัด</span>
        </div>
        <div class="info-row">
          <span class="label">เลขที่ใบแจ้งสินค้า:</span>
          <span class="value">ORD63314</span>
        </div>
      </div>
      <div class="info-right">
        <div class="info-row">
          <span class="label">ผู้ชำาระเงิน:</span>
          <span class="value">คุณ Admin Gump</span>
        </div>
        <div class="info-row">
          <span class="label">วันที่ทำรายการ:</span>
          <span class="value">07/10/2015 เวลา 14:18:06 น.</span>
        </div>
      </div>
    </div>
    <table class="table">
      <thead>
        <tr>
          <th>สินค้า/บริการ</th>
          <th>จำนวนเงิน</th>
        </tr>
      </thead>
      <tbody>
        <tr>
          <td>order#63314</td>
          <td>1,308.00 บาท</td>
        </tr>
      </tbody>
    </table>
    <!-- Barcode Section -->
    <div class="barcode">
      <canvas id="barcode"></canvas>
    </div>
    <!-- JavaScript to generate the barcode -->
    <script>
      // Generate the barcode using JsBarcode
      JsBarcode("#barcode", "806010064982946", {
        format: "CODE128",
        displayValue: false,
        width: 2,
        height: 60,
        margin: 0
      });
    </script>
    <!-- End Barcode Section -->
    <div class="footer">
      <p>คลิกปุ่ม "Print" เพื่อพิมพ์ใบแจ้งการชำระเงิน หรือ จด "รหัส 15 หลักใต้บาร์โค้ด" เพื่อนำไปชำระเงิน</p>
    </div>
  </div>
</body>
</html>
