<footer>
  <div class="toolbar toolbar-footer">
    <div class="toolbar-actions">
      <div class="btn-group">
        <div class="btn btn-basic" onclick={ notDeployed }>
          <i class="icon icon-plus"></i>
        </div>
        <div class="btn btn-basic" onclick={ executeQuery }>
          <i class="icon icon-cw"></i>
        </div>
      </div>

      <small>Rows 1-100</small>

      <div class="btn-group right">
        <div class="btn btn-basic">
          <i class="icon icon-left-open"></i>
        </div>
        <!--
        <div class="btn btn-basic">
          <i class="icon icon-cog"></i>
        </div>
        -->
        <div class="btn btn-basic">
          <i class="icon icon-right-open"></i>
        </div>
      </div>
    </div>
  </div>


  <style>
    /* footer */
    footer {
      position: fixed;
      width: calc(100% - 150px);
      bottom: 0;
    }
  </style>


  <script>
    /***********************************************
    * Settings
    ***********************************************/
    var that = this
  </script>
</footer>
