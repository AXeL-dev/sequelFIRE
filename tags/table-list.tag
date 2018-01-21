<table-list>
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


  <script>
    var that = this
    that.labels = null
    that.items = null

    var docRef = db.collection("timelines")
    docRef.get().then(function(querySnapshot){
      that.items = querySnapshot.docs
      that.labels = Object.keys(that.items[0].data())
      that.update()
    })
  </script>
</table-list>
