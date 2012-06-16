Ext.define('RpcDemo.model.Token'
  extend: 'Ext.data.Model'
  fields: [{
    name: 'token'
    type: 'string'
  }]
  proxy:
    type: 'rest'
    url: '/tokens'
    reader:
      type: 'json'
      root: 'user'
)
