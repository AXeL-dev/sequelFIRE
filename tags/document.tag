<document>
  <div if={ opts.document }>
    <div class="toolbar toolbar-header">

      <div class="toolbar-actions">
        <h3 class="title">{ opts.document.ref.path }</h3>

        <div class="pull-left">
          <button class="btn btn-default" onclick={ close  }>
            <span class="icon icon-left-open"></span>
            Back
          </button>
        </div>

        <div class="pull-right">
          <button class="btn btn-primary" onclick={ save }>
            Save
          </button>
          <button class="btn btn-default" onclick={ delete }>
            Delete
          </button>
        </div>
      </div>
    </div>

    <form>
      <div class="form-group">
        <label>id</label>
        <input type="text" class="form-control" value={ opts.document.id } disabled="disabled">
      </div>
      <div class="form-group" each={ field in Object.keys(fields).sort()  }>
        <label>
          { field }
          <small>({ fieldType(field) })</small>
        </label>

        <virtual if={ fieldType(field)=='array' || fieldType(field)=='object' }>
          <textarea data-field={ field } class="form-control" onchange={ updateItem }>{ JSON.stringify(item[field], null, 2) }</textarea>
        </virtual>
        <virtual if={ fieldType(field)!='array' && fieldType(field)!='object' }>
          <input data-field={ field } type="text" class="form-control" value={ item[field] } onchange={ updateItem }>
        </virtual>
      </div>
    </form>
  </div>


  <style>
    .title {
      display: inline-block;
      max-width: 70%;
    }
    .toolbar-header {
      position: fixed;
      width: calc(100% - 150px);
      top: 55px;
    }
    .toolbar-actions {
      text-align: center;
    }
    .pull-right {
      padding-right: 5px;
    }
    form {
      padding: 0 3%;
      margin-top: 50px;
    }
  </style>


  <script>
    /***********************************************
    * Settings
    ***********************************************/
    var that = this
    that.item = opts.document.data()
    that.fields = opts.document._fieldsProto


    /***********************************************
    * Functions
    ***********************************************/
    close() {
      that.parent.selectedDocument = null
      that.parent.update()
    }

    delete() {
      var ok = confirm('Are you sure to delete this document?')
      if(!ok) { return false }

      let id = opts.document.id
      let docRef = firestore.collection(opts.collection).doc(id)
      docRef.delete().then(function(){
        alert("Item deleted!")
        that.close()
      })
    }

    fieldType(field) {
      return that.fields[field].valueType.replace(/Value/, '')
    }

    save() {
      let id = opts.document.id
      let docRef = firestore.collection(opts.collection).doc(id)
      docRef.update(that.item)
      .then(function() {
        alert("success!")
      })
      .catch(function(error) {
        alert(error)
      })
    }

    updateItem(e) {
      let value = e.currentTarget.value
      let field = e.currentTarget.getAttribute('data-field')
      if(that.fieldType(field)=='array') {
        value = JSON.parse(value)
      }
      that.item[field] = value
    }
  </script>
</document>
