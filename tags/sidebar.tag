<sidebar>
  <nav class="nav-group">
    <h5 class="nav-group-title">Collections</h5>

    <a class="nav-group-item { active: selectedCollection == collection.id }" each={ collection in collections } onclick={ selectCollection.bind(this, collection.id) }>
      <i class="icon icon-folder"></i>
      { collection.id }
    </a>
  </nav>
  <!--
  <footer class="toolbar toolbar-footer">
    <div class="toolbar-actions">
      <i class="icon icon-plus"></i>
    </div>
  </footer>
  -->


  <style>
    i.float-right {
      float: right !important;
      cursor: pointer;
    }

    .nav-group-item.active, .nav-group-item:hover {
        background-color: #dcdfe1;
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
    that.collections = []
    that.selectedCollection = null


    /***********************************************
    * Observables
    ***********************************************/
    that.on('mount', function(){
      firestore.getCollections().then(function(collections) {
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
