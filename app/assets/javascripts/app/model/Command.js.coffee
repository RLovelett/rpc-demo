Ext.define('RpcDemo.model.Command'
  extend: 'Ext.data.Model'
  fields: [{
    name: 'id'
    type: 'int'
  }, {
    name: 'name'
    type: 'string'
  }, {
    name: 'arguments'
    type: 'string'
  }, {
    name: 'resque_id'
    type: 'string'
  }]
  proxy:
    type: 'rest'
    url: '/commands'
    reader:
      type: 'json'
      root: 'command'
)
