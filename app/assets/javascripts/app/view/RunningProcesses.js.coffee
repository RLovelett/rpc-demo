Ext.define('RpcDemo.view.RunningProcesses',
  extend: 'Ext.grid.Panel'
  alias: 'widget.running-processes'
  title: 'Running Processes'
  collapsible: true
  collapsed: true
  split: true
  height: 200
  minHeight: 200
  store: Ext.getStore('Commands')
  columns: [{
    header: 'Command Id'
    dataIndex: 'resque_id'
    flex: 2
  }, {
    header: 'Command'
    dataIndex: 'name'
    flex: 1
  }, {
    header: 'Arguments'
    dataIndex: 'arguments'
    flex: 3
  }]
  bbar: Ext.create('Ext.PagingToolbar',
    store: Ext.getStore('Commands')
    displayInfo: true
    displayMsg: 'Displaying Queued or Executing Commands {0} - {1} of {2}'
    emptyMsg: 'No commands are being executed.'
  )
)
