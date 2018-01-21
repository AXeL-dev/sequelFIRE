<sidebar>
  <nav class="nav-group">
    <h5 class="nav-group-title">Shortcut</h5>
    <a class="nav-group-item" each={ collection in collections }>
      <i class="icon icon-folder"></i>
      { collection }
    </a>
    <hr>
    <span class="nav-group-item">
      <input type="text" class="form-control" placeholder="Add Collection" onchange={ addCollection }>
    </span>
  </nav>


  <script>
    var that = this
    that.collections = []

    addCollection(e) {
      var collection = e.currentTarget.value
      that.collections.push(collection)
      e.currentTarget.value = ''
      that.update
    }
  </script>
</sidebar>
