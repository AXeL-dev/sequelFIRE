<footer>
  <div class="toolbar toolbar-footer">
    <div class="toolbar-actions">
      <div class="btn-group">
        <!--
        <div class="btn btn-basic" onclick={ notDeployed }>
          <i class="icon icon-plus"></i>
        </div>
        -->
        <div class="btn btn-basic" onclick={ executeQuery }>
          <i class="icon icon-cw"></i>
        </div>
      </div>

      <small>Page: { opts.page }</small>

      <div class="btn-group right">
        <div class="btn btn-basic { disabled: !opts.prevable }" onclick={ prev }>
          <i class="icon icon-left-open"></i>
        </div>
        <!--
        <div class="btn btn-basic">
          <i class="icon icon-cog"></i>
        </div>
        -->
        <div class="btn btn-basic { disabled: !opts.nextable }" onclick={ next }>
          <i class="icon icon-right-open"></i>
        </div>
      </div>
    </div>
  </div>


  <style>
    footer {
      position: fixed;
      width: calc(100% - 150px);
      bottom: 0;
    }
    .btn-group.right { float: right; }
  </style>


  <script>
    /***********************************************
    * Settings
    ***********************************************/
    var that = this

    next() {
      if(!opts.nextable) { return false }
      that.parent.next()
    }
    prev() {
      if(!opts.prevable) { return false }
      that.parent.prev()
    }
  </script>
</footer>
