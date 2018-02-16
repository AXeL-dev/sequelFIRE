<main>
  <div if={ !selectedDocument }>
    <filter fields={ fields }></filter>
    <collection fields={ fields } documents={ documents }></collection>
    <footer></footer>
  </div>
  <document if={ selectedDocument } fields={ fields } document={ selectedDocument }></document>


  <script>
    /***********************************************
    * Settings
    ***********************************************/
    var that = this
    that.fields = null
    that.documents = null

    that.selectedCollection = null
    that.selectedDocument = null
    that.filter = {
      field: null,
      operator: null,
      value: null
    }


    /***********************************************
    * Observables
    ***********************************************/
    obs.on("collectionChanged", function(collectionName) {
      that.selectedCollection = collectionName
      that.selectedDocument = null
      that.executeQuery()
    })

    obs.on("filterChanged", function(filter) {
      that.filter = filter
      that.executeQuery()
    })

    obs.on("documentChanged", function(document) {
      that.selectedDocument = document
      that.update()
    })


    /***********************************************
    * Functions
    ***********************************************/
    executeQuery(e) {
      if(e) { e.preventDefault() }  // prevent form submission

      let collectionRef = firestore.collection(that.selectedCollection)

      if(that.filter.field && that.filter.operator && that.filter.value) {
        collectionRef = collectionRef.where(that.filter.field, that.filter.operator, that.filter.value)
      }

      collectionRef = collectionRef.limit(10)
      collectionRef.get().then(querySnapshot => {
        that.documents = querySnapshot.docs
        that.fields = Object.keys(querySnapshot.docs[0]._fieldsProto).sort()
        that.update()
      })
    }

    notDeployed() {
      alert("This feature is not deployed yet! Sorry!")
    }
  </script>
</main>
