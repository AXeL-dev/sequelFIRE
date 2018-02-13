<filter>
  <div class="form-group">
    <form onsubmit={ executeQuery }>
      Filter:
      <select class="form-control" data-filter-target="field" onchange={ updateFilter } disabled={ !selectedCollection }>
        <option> - Field - </option>
        <option each={ field in fields } value={ field } selected={ filter.field == field }>{ field }</option>
      </select>
      <select class="form-control" data-filter-target="operator" onchange={ updateFilter } disabled={ !selectedCollection }>
        <option> - Operator - </option>
        <option value="==" selected={ filter.operator == '==' }> == </option>
        <option value="<" selected={ filter.operator == '<' }> < </option>
        <option value="<=" selected={ filter.operator == '<=' }> <= </option>
        <option value=">" selected={ filter.operator == '>' }> > </option>
        <option value=">=" selected={ filter.operator == '>=' }> >= </option>
      </select>
      <input ref="filterValue" type="text" class="form-control" disabled={ !selectedCollection } data-filter-target="value" onchange={ updateFilter } value={ filter.value } placeholder="value">
      <button type="submit" class="btn btn-default { disabled: !selectedCollection }">Filter</button>
      <div class="btn btn-basic" onclick={ removeFilter } if={ selectedCollection }>
        <i class="icon icon-cancel-circled"></i>
      </div>
    </form>
  </div>


  <style>
    /* button */
    :disabled, .disabled {
      background: #efefef;
      color: #999;
    }
    .btn:not(.disabled), .btn-basic i {
      cursor: pointer;
    }
    .btn-basic {
      margin: 0 !important;
      box-shadow: none;
    }
    .btn-group.right {
      position: absolute;
      right: 0;
    }

    /* form */
    .form-group {
      position: fixed;
      width: calc(100% - 150px);
      padding: 0 10px;
    }
    .form-control {
      width: auto;
      margin: 10px 5px;
    }
    input.form-control {
      padding: 0 10px;
    }
  </style>


  <script>
    /***********************************************
    * Settings
    ***********************************************/
    var that = this
    that.fields = null
    that.selectedCollection = null
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
      that.update()
    })


    /***********************************************
    * Functions
    ***********************************************/
    removeFilter() {
      that.filter = {
        field: null,
        operator: null,
        value: null
      }
      that.refs.filterValue.value = ''
    }

    updateFilter(e) {
      let target = e.currentTarget.getAttribute('data-filter-target')
      that.filter[target] = e.currentTarget.value
    }
  </script>
</filter>
