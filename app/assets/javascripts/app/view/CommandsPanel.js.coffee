Ext.define('RpcDemo.view.CommandsPanel',
  extend: 'Ext.form.Panel'
  alias: 'widget.commands-panel'
  autoScroll: true
  title: 'Commands'
  collapsible: true
  split: true
  flex: 1
  iconCls: 'silk-lightbulb-off'
  items: [{
    xtype: 'textareafield'
    name: 'command'
    fieldLabel: 'Command'
    anchor: '100%'
  }, {
    xtype: 'textareafield'
    name: 'arguments'
    fieldLabel: 'Args'
    anchor: '100%'
  }]
  buttons: [
    text: 'Run Command'
    action: 'run-command'
    handler: () ->
      store = Ext.getStore('Commands');
      values = @up('commands-panel').getForm().getValues()
      command = Ext.create('RpcDemo.model.Command',
        name: values.command
        arguments: values.arguments
      )
      store.add(command) if store
  ]
)
