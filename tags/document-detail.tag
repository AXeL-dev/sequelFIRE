<document-detail>
  <div if={ opts.document }>
    <div class="toolbar toolbar-header">
      <h3 class="title">{ opts.document.name }</h3>

      <div class="toolbar-actions">
        <button class="btn btn-default" onclick={ close  }>
          <span class="icon icon-left-open"></span>
          Back
        </button>

        <div class="pull-right">
          <button class="btn btn-primary">
            Save
          </button>
          <button class="btn btn-default">
            Delete
          </button>
        </div>
      </div>
    </div>

    <form>
      <div class="form-group" each={ field in Object.keys(opts.document.fields)  }>
        <label>
          { field }
          <span class="btn btn-mini btn-default">{ fieldType(field) }</span>
        </label>
        <input if={ !fieldType(field).match(/map|array/) } type="text" class="form-control" value={ showValue(field) }>
        <textarea if={ fieldType(field).match(/map|array/) } class="form-control">{ JSON.stringify(showValue(field)) }</textarea>
      </div>
    </form>
  </div>


  <style>
    .toolbar-header {
      position: fixed;
      width: calc(100% - 150px);
      top: 22px;
    }
    .pull-right { padding-right: 5px; }
    form {
      padding: 0 3%;
      margin-top: 80px;
    }
    .btn-mini {
      font-size: 10px;
      padding: 0 3px;
    }
  </style>


  <script>
    var that = this

    close() {
      that.parent.selectedDocument = null
      that.parent.update()
    }

    fieldType(field) {
      return Object.keys(opts.document.fields[field])[0].replace(/Value/, '')
    }

    showValue(field) {
      let fieldType = that.fieldType(field) + 'Value'
      return opts.document.fields[field][fieldType]
    }
  </script>
</document-detail>
