<collection-list>
  <div if={ !selectedDocument }>
    <div class="form-group">
      <textarea class="form-control" rows="2" placeholder="collection('xxxx').where(...).limit(10)" onchange={ updateQuery }></textarea>
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
          <td>{ item.name.split('/').pop() }</td>
          <td each={ field in fields }>{ showValue(item.fields[field]) }</td>
        </tr>
      </tbody>
    </table>
  </div>
  <document-detail if={ selectedDocument } document={ selectedDocument }></document-detail>


  <style>
    .form-group { margin-bottom: 0; }
    .form-control {
      width: 98%;
      margin: 10px 1%;
    }

    .table-striped tr:hover {
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
  </style>


  <script>
    /***********************************************
    * Settings
    ***********************************************/
    var that = this
    that.fields = null
    that.items = null
    that.selectedDocument = null

    let projectName = 'tournament-7e3b7'
    let apiKey = "AIzaSyCv8ZjenJii6cjYyKojQfxygCH1pWIj9DQ"
    let path = 'tournaments'


    /***********************************************
    * Observables
    ***********************************************/
    that.on('mount', function(){
      let url = 'https://firestore.googleapis.com/v1beta1/projects/'+ projectName +'/databases/(default)/documents/'+ path +'?key=' + apiKey
      fetch(url).then(function(response){
        return response.json();
      }).then(function(json){
        that.fields = Object.keys(json.documents[0].fields)
        that.items = json.documents
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
