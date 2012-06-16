Ext.define('RpcDemo.store.Commands'
  extend: 'Ext.data.Store'
  model: 'RpcDemo.model.Command'
  storeId: 'Commands'
  autoLoad: true
  autoSync: true
)
