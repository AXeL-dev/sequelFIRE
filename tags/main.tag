<main>
  <div if={ !selectedDocument }>
    <filter fields={ fields }></filter>
    <collection fields={ fields } documents={ documents }></collection>
    <footer page={ lastItems.length } perPage={ perPage } nextable={ nextable } prevable={ prevable }></footer>
  </div>
  <document if={ selectedDocument } fields={ fields } collection={ selectedCollection } document={ selectedDocument }></document>


  <script>
    /***********************************************
    * Settings
    ***********************************************/
    var that = this
    that.fields = null
    that.documents = null

    that.selectedCollection = null
    that.lastItems = []
    that.perPage = 30
    that.nextable = true
    that.prevable = false

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

      if(that.lastItems.length > 0) {
        collectionRef = collectionRef.startAfter(that.lastItems[that.lastItems.length - 1])
      }

      collectionRef = collectionRef.limit(that.perPage)
      collectionRef.get().then(querySnapshot => {
        if(querySnapshot.docs.length == 0) {
          that.nextable = false
          that.update()
          return false
        }
        if(querySnapshot.docs.length < that.perPage) {
          that.nextable = false
        }
        that.documents = querySnapshot.docs
        that.fields = Object.keys(querySnapshot.docs[0]._fieldsProto).sort()
        that.lastItems.push(querySnapshot.docs[querySnapshot.docs.length-1])
        if(that.lastItems.length < 2) {
          that.prevable = false
        }
        that.update()
      })
    }

    next() {
      that.prevable = true
      that.executeQuery()
    }
    prev() {
      that.nextable = true
      if(that.lastItems.length < 2) {
        return false
      }

      that.lastItems.pop()
      that.lastItems.pop()
      that.executeQuery()
    }

    notDeployed() {
      alert("This feature is not deployed yet! Sorry!")
    }

    refresh() {
      that.lastItems.pop()
      that.executeQuery()
    }
  </script>
</main>
