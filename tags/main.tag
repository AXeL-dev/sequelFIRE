<main>
  <div if={ !selectedDocument }>
    <filter></filter>
    <collection></collection>
    <footer></footer>
  </div>

  <document if={ selectedDocument } document={ selectedDocument }></document>


  <script>
    /***********************************************
    * Settings
    ***********************************************/
    var that = this
    that.fields = null
    that.items = null
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
      that.executeQuery()
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
        that.items = querySnapshot.docs
        that.fields = Object.keys(querySnapshot.docs[0]._fieldsProto).sort()
        that.update()
      })
    }

    notDeployed() {
      alert("This feature is not deployed yet! Sorry!")
    }

    removeFilter() {
      that.filter = {
        field: null,
        operator: null,
        value: null
      }
      that.refs.filterValue.value = ''
      that.executeQuery()
    }

    showDetail(item) {
      that.selectedDocument = item
      that.update()
    }

    showValue(data) {
      if(!data || data == undefined || data == null) { return data }
      return JSON.stringify(Object.values(data)[0]).replace(/"/g, '')
    }

    updateFilter(e) {
      let target = e.currentTarget.getAttribute('data-filter-target')
      that.filter[target] = e.currentTarget.value
    }
  </script>
</main>
