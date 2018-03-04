<before-login>
  <div class="window">
    <div class="toolbar toolbar-header">
      <h1 class="title">sequelFIRE🔥</h1>
    </div>
    <div style="text-align: center; margin-top: 30px;">
      <h5>Select Service Account JSON File for the project.</h5>
      <button class="btn btn-large btn-primary" onclick={ selectFile }>Select File..</button>
    </div>
  </div>


  <script>
    var that = this

    selectFile(e) {
      dialog.showOpenDialog({properties: ['openFile']}, function(filePaths){
        var request = new XMLHttpRequest()
        request.open("GET", filePaths[0], false)
        request.send(null)
        var certJSON = JSON.parse(request.responseText)

        projectId = certJSON['project_id']
        firestore = new Firestore({
          projectId: projectId,
          keyFilename: filePaths[0],
        })
        riot.mount('after-login')
        that.unmount(true)
      })
    }
  </script>
</before-login>
