<collection>
  <table class="table-striped">
    <thead>
      <tr>
        <th>id</th>
        <th each={ field in opts.fields }>{ field }</th>
      </tr>
    </thead>
    <tbody if={ opts.documents }>
      <tr each={ document, key in opts.documents } ondblclick={ showDetail.bind(this, document) }>
        <td>{ document.id }</td>
        <td each={ field in parent.opts.fields }>{ document.data()[field] }</td>
      </tr>
    </tbody>
    <tbody if={ !opts.documents }>
      <tr>
        <td>No data found. Select collection from left pane.</td>
      </tr>
    </tbody>
  </table>


  <style>
    /* table */
    .table-striped {
      padding-top: 45px;
      margin-bottom: 35px;
    }
    .table-striped tbody tr:hover {
      color: #fff;
      background-color: #116cd6 !important;
    }
    td {
      width: auto;
      max-width: 350px;
      white-space: nowrap;
      overflow: hidden;
      text-overflow: ellipsis;
      -o-text-overflow: ellipsis; /* Opera9,10対応 */
    }
  </style>


  <script>
    /***********************************************
    * Settings
    ***********************************************/
    var that = this


    /***********************************************
    * Functions
    ***********************************************/
    showDetail(document) {
      obs.trigger('documentChanged', document)
    }
  </script>
</collection>
