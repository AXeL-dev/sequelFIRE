<sidebar>
  <nav class="nav-group">
    <h5 class="nav-group-title">Collections</h5>

    <div class="nav-group-item" if={ collections.length == 0 }>
      Loading collections..
    </div>
    <a class="nav-group-item { active: selectedCollection == collection.id }" each={ collection in collections } onclick={ selectCollection.bind(this, collection.id) }>
      <i class="icon icon-folder"></i>
      { collection.id }
    </a>
  </nav>


  <style>
    i.float-right {
      float: right !important;
      cursor: pointer;
    }

    .nav-group-item.active, .nav-group-item:hover {
        background-color: #dcdfe1;
    }
  </style>


  <script>
    /***********************************************
    * Settings
    ***********************************************/
    var that = this
    that.collections = []
    that.selectedCollection = null


    /***********************************************
    * Observables
    ***********************************************/
    that.on('mount', function(){
      console.log("aaa")
      console.log(firestore)
      firestore.getCollections().then(function(collections) {
        console.log("bbb")
        that.collections = collections
        that.update()
      })
    })


    /***********************************************
    * Functions
    ***********************************************/
    selectCollection(collectionName) {
      if(that.selectedCollection == collectionName) { return false }

      that.selectedCollection = collectionName
      obs.trigger('collectionChanged', collectionName)
    }
  </script>
</sidebar>
