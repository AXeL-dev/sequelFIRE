<query>
  <div class="">
    <textarea id="queryString" class="form-control" rows="4" placeholder="firestore.collection('xxx').where('yy', '==', 'zz').update(\{foo: 'bar'\})"></textarea>
    <button class="btn btn-primary" onclick={ runQuery }>Run</button>

    <p if={ message }>{ message }</p>
  </div>


  <style media="screen">
    div { margin: 10px 1%; }
  </style>


  <script>
    var that = this

    runQuery() {
      let queryString = document.getElementById('queryString').value
      console.log(queryString)
      console.log(queryString.split('.'))
    }
  </script>
</query>
