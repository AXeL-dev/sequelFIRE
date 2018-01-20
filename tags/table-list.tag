<table-list>
  <table class="table-striped">
    <thead>
      <tr>
        <th>id</th>
        <th>title</th>
        <th>createdAt</th>
      </tr>
    </thead>
    <tbody if={ items }>
      <tr each={ item, key in items }>
        <td>{ item.id }</td>
        <td>{ item.data().title }</td>
        <td>{ item.data().createdAt }</td>
      </tr>
    </tbody>
  </table>


  <script>
    var that = this
    that.items = null

    var docRef = db.collection("timelines").orderBy('updatedAt', 'desc')
    docRef.get().then(function(querySnapshot){
      that.items = querySnapshot.docs
      that.update()
    })
  </script>
</table-list>
