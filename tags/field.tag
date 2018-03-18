<field>
  <div>
    <virtual if={ opts.type == 'timestamp' }>
      <input data-field={ opts.field } type="datetime-local" class="form-control" value={ timestampValue( opts.item[opts.field] ) } onchange={ updateItem }>
    </virtual>

    <virtual if={ opts.type == 'boolean' }>
      <select data-field={ opts.field } class="form-control" onchange={ updateItem }>
        <option value={ true } selected={ opts.item[opts.field] }>true</option>
        <option value={ false } selected={ !opts.item[opts.field] }>false</option>
      </select>
    </virtual>

    <virtual if={ opts.type == 'string'  }>
      <input data-field={ opts.field } type="text" class="form-control" value={ opts.item[opts.field] } onchange={ updateItem }>
    </virtual>

    <virtual if={ opts.type == 'null'  }>
      <input data-field={ opts.field } type="text" class="form-control" value={ null } placeholder="null" onchange={ updateItem }>
    </virtual>

    <virtual if={ opts.type == 'map'  }>
      <textarea name="name" rows="3" class="form-control" data-field={ opts.field } onchange={ updateItem }>
        { JSON.stringify(opts.item[opts.field], null, '\t') }
      </textarea>
    </virtual>
  </div>


  <style>
    select { height: 32px; }
  </style>


  <script>
    updateItem(e) {
      let value = e.currentTarget.value
      let field = e.currentTarget.getAttribute('data-field')

      switch(opts.type) {
        case 'boolean':
          value = (value=='true') ? true : false
          break;
        case 'timestamp':
          value = moment(value).toDate()
          break;
        case 'map':
          value = JSON.parse(value)
          break;
      }

      let changedField = {
        field: field,
        value: value
      }
      console.log(changedField)
      obs.trigger('itemFieldChanged', changedField)
    }

    timestampValue(string) {
      return moment(string).format('YYYY-MM-DDThh:mm')
    }
  </script>
</field>
