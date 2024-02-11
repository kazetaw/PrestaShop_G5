function doGet(request){

 var imageurl = request.parameter.imageurl
 //var imageurl = "https://i.ibb.co/9Ww2DwB/26761-BF6-BFE3-494-C-98-F7-F6-B56-AA586-C1.jpg"
 var result = extractslip(imageurl)
 result = extracttext(result)
 console.log(result)
 var result = JSON.stringify(result);
 return ContentService.createTextOutput(result).setMimeType(ContentService.MimeType.JSON); 
}

function extractslip(imageurl) {
  var imageBlob = UrlFetchApp.fetch(imageurl).getBlob();
  var resource = {
    title:imageBlob.getName(),
    mimeType: imageBlob.getContentType()
  }
  var options = {
    ocr:true
  }
  var docFile = Drive.Files.insert(resource,imageBlob,options)
  var doc = DocumentApp.openById(docFile.id)
  var text = doc.getBody().getText()
  //console.log(text)
  Drive.Files.remove(docFile.id)
  //console.log(text)
  //result = extracttext(text)
  return text
}

function extracttext(text){

//   var text = `07:08 Bangkok Bank
// รายการสําเร็จ
// 27 มี.ค. 65, 07:07
// จํานวนเงิน 1.00 THB
// จาก
// นาย วินน์ 926-0-xxx401 ธนาคารกรุงเทพ
// ไปที่
// u.ส. สุนั้น ลาภดํารงกิจ 042-2-xxx686 ธนาคารกสิกรไทย , , ,
// ค่าธรรมเนียม 0.00 THB
// 300000.14
// หมายเลขอ้างอิง 403428 เลขที่อ้างอิง 2022032707075223007878308
// นางยุวดี ศรีสวัสดิ์ 123
// สแกนเพื่อตรวจสอบ
// รายการโปรด
// ส่งข้อความ SMS
// แชร์
// หมวดหมู่
// อื่นๆ`

  var tid = text.match(/[0-9]{20,30}/g)[0];
  //console.log(tid)
  var amt = text.match(/[0-9]+\.[0-9]{2}/g)[0];
  //console.log(amt)
  
  name = text.match(/(นาย|นาง|น.ส.|u.ส.)[ก-๛a-z ]+/g)
  //console.log(name)
  var nname = []
  for (let i = 0; i < name.length; i++) {
    nname.push(name[i].trim());
  }
  //console.log(nname)
  nfrom = nname[0]
  nto = nname[1]
  
  //act = text.match(/([0-9|x|X]+-+[0-9|(x|X)]+-+)[0-9|(x|X)]+/g)
  act = text.match(/([0-9]|x|X)+-([0-9]|x|X)+-([0-9]|x|X)+/g)
  //console.log(act)
  actfrom = act[0]
  actto = act[1]

  var result = {}
  result['tid'] = tid
  result['from'] = {'name':nfrom,'account':actfrom}
  result['to'] = {'name':nto,'account':actto}
  result['amount'] = amt
  //console.log(result)
  return result
  
  // //console.log(tid)
  // //console.log(amt)
  // //console.log(nname)
  // //console.log(act)
  // var result = {}
  // result['tid'] = tid
  // result['amount'] = amt
  // result['from'] = name[0]
  // result['to'] = name[1]
  // console.log(result)
  // return result
}