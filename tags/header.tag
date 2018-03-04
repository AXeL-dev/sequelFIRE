<header>
  <div class="toolbar toolbar-header">
    <h1 class="title">sequelFIRE🔥</h1>

    <div class="toolbar-actions">
      <div class="form-group left">
        <select class="form-control" onchange={ changeProject }>
          <optgroup label="Projects">
            <option value={ projectId }>{ projectId }</option>
            <option value={ key } each={ project, key in localProjects } if={ key != projectId }>{ key }</option>
          </optgroup>
          <optgroup label="---------">
            <option value="">New Connection</option>
          </optgroup>
        </select>
      </div>
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
    .form-group.left {
      float: left;
      position: absolute;
      left: 5px;
    }
  </style>


  <script>
    /***********************************************
    * Settings
    ***********************************************/
    var that = this
    that.selectedTab = 'contents'
    that.localProjects = JSON.parse(localStorage.getItem('projects')) || {}
    that.projectId = that.parent.opts.projectId


    /***********************************************
    * Functions
    ***********************************************/
    changeTab(tab) {
      that.selectedTab = tab
      that.update()
    }

    changeProject(e) {
      obs.trigger('projectChanged', e.currentTarget.value)
    }
</header>
