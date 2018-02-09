<sidebar>
  <nav class="nav-group">
    <h5 class="nav-group-title">Collections</h5>
    <div class="form-group">
      <input class="form-control" placeholder="add collection" onchange={ addCollection }>
    </div>
    <hr>

    <a class="nav-group-item { active: selectedCollection == collection }" each={ collection in collections } data-collection={ collection } onclick={ selectCollection }>
      <i class="icon icon-folder"></i>
      { collection }
      <i class="icon icon-cancel float-right" data-collection={ collection } onclick={ removeCollection }></i>
    </a>
    <!-- FIXME  -->
    <a class="nav-group-item { active: selectedCollection == collection }" data-collection="timelines" onclick={ selectCollection }>
      <i class="icon icon-folder"></i>
      timelines
      <i class="icon icon-cancel float-right" data-collection="timelines" onclick={ removeCollection }></i>
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

    removeCollection(e) {
      e.preventDefault()
      that.collections = that.collections.filter(function(v){
        return v != e.currentTarget.getAttribute('data-collection')
      })
      that.update()
    }

    selectCollection(e) {
      // ignore when clicking remove icon or select already selected collection
      let collectionName = e.currentTarget.getAttribute('data-collection')
      if(e.target.classList.contains('icon-cancel') || collectionName == that.selectedCollection) {
        return false
      }
      that.selectedCollection = collectionName
      obs.trigger('collectionChanged', collectionName)
    }
  </script>
</sidebar>
