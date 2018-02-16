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
          <button class="btn btn-default">
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
        <input if={ fieldType(field) } data-field={ field } type="text" class="form-control" value={ item[field] } onchange={ updateItem }>
        <textarea if={ !fieldType(field) } class="form-control">{ JSON.stringify(item[field]) }</textarea>
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

    fieldType(field) {
      return that.fields[field].valueType.replace(/Value/, '')
    }

    save() {
      let id = opts.document.id
      let docRef = firestore.collection('timelines').doc(id)
      docRef.set(that.item)
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
      that.item[field] = value
    }
  </script>
</document>
