Ext.define('RpcDemo.view.Viewport', {
  extend: 'Ext.container.Viewport'
  layout: 'border'
  items: [{
    xtype: 'panel'
    region: 'north'
    title: false
    border: false
    margins: '0 0 5 0'
  }, {
    xtype: 'commands-panel'
    region: 'west'
  }, {
    xtype: 'running-processes'
    region: 'south'
  }, {
    xtype: 'results-panel'
    region: 'center'
  }]
})
