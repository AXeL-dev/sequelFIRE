<field>
  <div>
    <virtual if={ opts.type == 'timestamp' }>
      <input data-field={ opts.field } type="datetime-local" class="form-control" value={ timestampValue( opts.item[opts.field] ) }>
    </virtual>

    <virtual if={ opts.type == 'boolean' }>
      <select data-field={ opts.field } class="form-control">
        <option value={ true } selected={ opts.item[opts.field] }>true</option>
        <option value={ false } selected={ !opts.item[opts.field] }>false</option>
      </select>
    </virtual>

    <virtual if={ opts.type == 'string'  }>
      <input data-field={ opts.field } type="text" class="form-control" value={ opts.item[opts.field] }>
    </virtual>

    <virtual if={ opts.type == 'null'  }>
      <input data-field={ opts.field } type="text" class="form-control" value={ null } placeholder="null">
    </virtual>

    <virtual if={ opts.type == 'map'  }>
      <textarea name="name" rows="3" class="form-control disabled" readonly>
        { JSON.stringify(opts.item[opts.field], null, '\t') }
      </textarea>
    </virtual>
  </div>


  <style>
    select { height: 32px; }
  </style>


  <script>
    timestampValue(string) {
      return moment(string).format('YYYY-MM-DDThh:mm')
    }
  </script>
</field>
