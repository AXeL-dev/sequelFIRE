<before-login>
  <div class="window">
    <div class="toolbar toolbar-header">
      <h1 class="title">sequelFIRE🔥</h1>
    </div>
    <div class="window-content">
      <div class="pane-group">
        <div class="pane-sm sidebar">
          <nav class="nav-group">
            <h5 class="nav-group-title">History</h5>
            <div class="nav-group-item" each={ project, key in localProjects } onclick={ changeProject.bind(this, key) }>
              <i class="icon icon-database"></i>
              { key }
              <i class="icon float-right icon-cancel"></i>
            </div>
          </nav>
        </div>
        <div class="pane">
          <div style="text-align: center; margin-top: 30px;">
            <h5>Select Service Account JSON File for the project.</h5>
            <button class="btn btn-large btn-primary" onclick={ selectFile }>Select File..</button>
          </div>
        <div>
      </div>
    </div>
  </div>


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
    var that = this
    that.localProjects = JSON.parse(localStorage.getItem('projects')) || {}

    changeProject(projectId) {
      try {
        fs.statSync(that.localProjects[projectId])
        firestore = new Firestore({
          projectId: projectId,
          keyFilename: that.localProjects[projectId]
        })
        
        riot.mount('after-login', 'after-login', {'projectId': projectId})
        that.unmount(true)
      }catch(e) {
        alert('Error! Check console for detail.')
        console.log(e)
      }
    }

    loadCertJSON(path) {
      var request = new XMLHttpRequest()
      request.open("GET", path, false)
      request.send(null)
      return(JSON.parse(request.responseText))
    }

    selectFile(e) {
      dialog.showOpenDialog({properties: ['openFile']}, function(filePaths){
        if(!filePaths) { return false; } // cancel

        var certJSON = that.loadCertJSON(filePaths[0])
        projectId = certJSON['project_id']

        that.localProjects[projectId] = filePaths[0]
        localStorage.setItem('projects', JSON.stringify(that.localProjects))

        that.changeProject(projectId)
      })
    }
  </script>
</before-login>
