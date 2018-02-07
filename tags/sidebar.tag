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
  </script>
</sidebar>
