<collection-list>
  <div if={ !selectedDocument }>
    <div class="form-group">
      <input type="text" class="form-control" disabled={ !selectedCollection } placeholder='WHERE query' onchange={ updateQuery }>
    </div>

    <table class="table-striped">
      <thead>
        <tr>
          <th>id</th>
          <th each={ field in fields }>{ field }</th>
        </tr>
      </thead>
      <tbody if={ items }>
        <tr each={ item, key in items } ondblclick={ showDetail.bind(this, item) }>
          <td>{ item.id }</td>
          <td each={ field in fields }>{ item.data()[field] }</td>
        </tr>
      </tbody>
      <tbody if={ !items }>
        <tr>
          <td>No data found. Add and select collection from left pane.</td>
        </tr>
      </tbody>
    </table>
  </div>
  <document-detail if={ selectedDocument } document={ selectedDocument }></document-detail>
  <footer class="toolbar toolbar-footer">
    <div class="toolbar-actions">
      <div class="btn-group">
        <div class="btn btn-basic">
          <i class="icon icon-plus"></i>
        </div>
        <div class="btn btn-basic">
          <i class="icon icon-cw"></i>
        </div>
      </div>

      <small>Rows 1-100</small>

      <div class="btn-group right">
        <div class="btn btn-basic">
          <i class="icon icon-left-open"></i>
        </div>
        <div class="btn btn-basic">
          <i class="icon icon-cog"></i>
        </div>
        <div class="btn btn-basic">
          <i class="icon icon-right-open"></i>
        </div>
      </div>
    </div>
  </footer>


  <style>
    .btn-basic {
      margin: 0 !important;
      box-shadow: none;
    }
    .form-group { margin-bottom: 0; }
    .form-control {
      width: 98%;
      margin: 10px 1%;
    }

    .btn-group.right {
      position: absolute;
      right: 0;
    }

    .table-striped tbody tr:hover {
      color: #fff;
      background-color: #116cd6 !important;
    }

    td {
      width: auto;
      max-width: 350px;
      white-space: nowrap;
      overflow: hidden;
      text-overflow: ellipsis;
      -o-text-overflow: ellipsis; /* Opera9,10対応 */
    }

    footer {
      position: absolute;
      width: 100%;
      bottom: 0;
    }
  </style>


  <script>
    /***********************************************
    * Settings
    ***********************************************/
    var that = this
    that.fields = null
    that.items = null
    that.selectedCollection = null
    that.selectedDocument = null


    /***********************************************
    * Observables
    ***********************************************/
    obs.on("collectionChanged", function(collectionName) {
      that.selectedCollection = collectionName
      let collectionRef = firestore.collection(collectionName).limit(5)
      collectionRef.get().then(querySnapshot => {
        that.items = querySnapshot.docs
        that.fields = Object.keys(querySnapshot.docs[0]._fieldsProto)
        that.update()
      })
    })


    /***********************************************
    * Functions
    ***********************************************/
    showDetail(item) {
      that.selectedDocument = item
      that.update()
    }

    showValue(data) {
      if(!data || data == undefined || data == null) { return data }
      return JSON.stringify(Object.values(data)[0]).replace(/"/g, '')
    }

    updateQuery(e) {
      var queryText = e.currentTarget.value
      var queries = queryText.split('.')

      rootCollection = (queries[0].match(/collection\((.*?)\)/))
      if(!rootCollection) { return false }
      var docRef = db.collection(rootCollection[1])

      for(var i = 1; i < queries.length; i++) {
        ref = queries[i].match(/(collection|doc|limit|where)\((.*?)\)/)
        if(!ref) { continue }
        switch(ref[1]) {
          case 'collection':
            docRef.collection(ref[2])
            break
          case 'doc':
            docRef.doc(ref[2])
            break
          case 'where':
            var params = ref[2].split(",").map(function(element) {
              return element.trim().replace(/"/g, "")
            })
            docRef.where(params[0], params[1], params[2])
            break
          case 'limit':
            docRef.limit(Number(ref[2]))
            break
          case 'orderBy':
            var params = ref[2].split(",")
            docRef.orderBy(params[0], params[1])
            break
        }
      }
      docRef.get().then(function(querySnapshot){
        that.items = querySnapshot.docs
        that.fields = Object.keys(that.items[0].data())
        that.update()
      })
    }
  </script>
</collection-list>
