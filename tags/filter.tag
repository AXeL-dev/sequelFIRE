<filter>
  <div class="form-group">
    <form onsubmit={ executeQuery }>
      Filter:
      <select class="form-control" data-filter-target="field" onchange={ updateFilter } disabled={ !opts.fields }>
        <option> - Field - </option>
        <option each={ field in opts.fields } value={ field } selected={ filter.field == field }>{ field }</option>
      </select>
      <select class="form-control" data-filter-target="operator" onchange={ updateFilter } disabled={ !opts.fields }>
        <option> - Operator - </option>
        <option value="==" selected={ filter.operator == '==' }> == </option>
        <option value="<" selected={ filter.operator == '<' }> < </option>
        <option value="<=" selected={ filter.operator == '<=' }> <= </option>
        <option value=">" selected={ filter.operator == '>' }> > </option>
        <option value=">=" selected={ filter.operator == '>=' }> >= </option>
      </select>
      <input ref="filterValue" type="text" class="form-control" disabled={ !opts.fields } data-filter-target="value" onchange={ updateFilter } value={ filter.value } placeholder="value">
      <button type="submit" class="btn btn-default { disabled: !opts.fields }">Filter</button>
      <div class="btn btn-basic" onclick={ removeFilter } if={ opts.fields }>
        <i class="icon icon-cancel-circled"></i>
      </div>
    </form>
  </div>


  <style>
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
    that.filterChanged = false
    that.filter = {
      field: null,
      operator: null,
      value: null
    }


    /***********************************************
    * Functions
    ***********************************************/
    executeQuery(e) {
      e.preventDefault()
      if(that.filterChanged) {
        obs.trigger('filterChanged', that.filter)
      }
      that.filterChanged = false
    }

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
      that.filterChanged = true
    }
  </script>
</filter>
