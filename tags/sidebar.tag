<sidebar>
  <nav class="nav-group">
    <h5 class="nav-group-title">Shortcut</h5>
    <a class="nav-group-item" each={ collection in collections }>
      <i class="icon icon-folder"></i>
      { collection }
    </a>
  </nav>


  <script>
    var that = this
    that.collections = []

    // let projectName = 'tournament-7e3b7'
    // let apiKey = "AIzaSyCv8ZjenJii6cjYyKojQfxygCH1pWIj9DQ"
    //
    // let headers = {
    //   'Accept': 'application/json',
    //   'Content-Type': 'application/json'
    // }
    //
    // let rootCollectionsUrl = 'https://firestore.googleapis.com/v1beta1/projects/'+ projectName +'/databases/(default)/documents/tournaments/:listCollectionIds?key='+ apiKey
    // fetch(rootCollectionsUrl, {method: "POST", headers: headers}).then(function(response){
    //   return response.json();
    // }).then(function(json){
    //   that.collections = json.collectionIds
    //   that.update()
    // });
  </script>
</sidebar>
