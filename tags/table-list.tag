<table-list>
  <div class="form-group">
    <textarea class="form-control" rows="2" placeholder="collection('xxxx').where(...).limit(10)" onchange={ updateQuery }></textarea>
  </div>

  <table class="table-striped">
    <thead>
      <tr>
        <th>id</th>
        <th each={ label in labels }>{ label }</th>
      </tr>
    </thead>
    <tbody if={ items }>
      <tr each={ item, key in items }>
        <td>{ item.id }</td>
        <td each={ label in labels }>{ item.data()[label] }</td>
      </tr>
    </tbody>
  </table>


  <style>
    .form-group { margin-bottom: 0; }
    .form-control {
      width: 98%;
      margin: 10px 1%;
    }
  </style>


  <script>
    var that = this
    that.labels = null
    that.items = null




    // var docRef = db.collection("timelines").limit(3)
    // docRef.get().then(function(querySnapshot){
    //   that.items = querySnapshot.docs
    //   that.labels = Object.keys(that.items[0].data())
    //   that.update()
    // })

    let projectName = 'tournament-7e3b7'
    let apiKey = "AIzaSyCv8ZjenJii6cjYyKojQfxygCH1pWIj9DQ"
    let path = 'tournaments/lJO8z1lh3BwPwXEsVREM'
    fetch('https://firestore.googleapis.com/v1beta1/projects/'+ projectName +'/databases/(default)/documents/'+ path +'?key='+key).then(function(response){
      return response.json();
    }).then(function(json){
      console.log(json);
    });

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
        that.labels = Object.keys(that.items[0].data())
        that.update()
      })
    }
  </script>
</table-list>
