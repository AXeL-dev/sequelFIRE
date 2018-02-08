<header>
  <div class="toolbar toolbar-header">
    <h1 class="title">sequelFIRE🔥</h1>

    <div class="toolbar-actions">
      <div class="btn-group">
        <button class="btn btn-default { active: selectedTab == 'contents' }" onclick={ changeTab.bind(this, 'contents') }>
          <span class="icon icon-menu"></span>
          Contents
        </button>
        <button class="btn btn-default { active: selectedTab == 'query' }" onclick={ changeTab.bind(this, 'query') }>
          <span class="icon icon-search"></span>
          Query
        </button>
      </div>
    </div>
  </div>


  <style>
    .toolbar-actions { text-align: center; }
  </style>


  <script>
    /***********************************************
    * Settings
    ***********************************************/
    var that = this
    that.selectedTab = 'contents'


    /***********************************************
    * Functions
    ***********************************************/
    changeTab(tab) {
      that.selectedTab = tab
      that.update()
    }
</header>
