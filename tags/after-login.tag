<after-login>
  <div class="window">
    <header></header>
    <div class="window-content">
      <div class="pane-group">
        <div class="pane-sm sidebar">
          <sidebar></sidebar>
        </div>
        <div class="pane">
          <main></main>
        <div>
      </div>
    </div>
  </div>


  <script>
    var that = this

    obs.on('projectChanged', function(project){
      if(project=='') {
        riot.mount('before-login')
        that.unmount(true)
      }
    })
  </script>
</after-login>
