<sidebar>
  <nav class="nav-group">
    <h5 class="nav-group-title">Collections</h5>
    <div class="form-group">
      <input class="form-control" placeholder="add collection" onchange={ addCollection }>
    </div>
    <hr>

    <a class="nav-group-item { active: selectedCollection == collection }" each={ collection in collections } onclick={ selectCollection.bind(this, collection) }>
      <i class="icon icon-folder"></i>
      { collection }
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
    .form-control {
      width: 90%;
      margin-left: 5%;
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
    * Functions
    ***********************************************/
    addCollection(e) {
      that.collections.push(e.currentTarget.value)
      e.currentTarget.value = null
      that.update()
    }

    selectCollection(collectionName) {
      that.selectedCollection = collectionName
      obs.trigger('collectionChanged', collectionName)
    }
  </script>
</sidebar>
