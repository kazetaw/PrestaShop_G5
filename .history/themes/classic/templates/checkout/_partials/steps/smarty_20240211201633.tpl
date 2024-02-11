<!-- Modal สำหรับการแนบหลักฐานการโอน -->
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
