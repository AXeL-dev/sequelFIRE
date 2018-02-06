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
          <button class="btn btn-primary" onclick={ save }>
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
          <small>({ fieldType(field) })</small>
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

    save() {
      let apiKey = "AIzaSyCv8ZjenJii6cjYyKojQfxygCH1pWIj9DQ"
      let url = 'https://firestore.googleapis.com/v1beta1/projects/tournament-7e3b7/databases/(default)/documents/tournaments/BPrd0K0aGjZSEu3T7dPK?fields=fields&key=' + apiKey
      // let url = 'https://firestore.googleapis.com/v1beta1/projects/'+ projectName +'/databases/(default)/documents/'+ path +'?key=' + apiKey
      fetch(url, {
        method: 'PATCH',
        headers: { 'Content-Type':'application/x-www-form-urlencoded' },
        body: {
         "fields": {
            "title": {
             "stringValue": "APIで変えた名前2"
            }
          }
        }
      }).then(function(response){
        return response.json();
      }).then(function(json){
        console.log(json)
      })
    }

    showValue(field) {
      let fieldType = that.fieldType(field) + 'Value'
      return opts.document.fields[field][fieldType]
    }
  </script>
</document-detail>
