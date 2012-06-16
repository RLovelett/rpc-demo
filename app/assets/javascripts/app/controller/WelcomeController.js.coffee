Ext.define('RpcDemo.controller.WelcomeController',
  extend: 'Ext.app.Controller'
  init: () ->
    tokenStore    = Ext.create('RpcDemo.store.Tokens')
    commandsStore = Ext.create('RpcDemo.store.Commands')
)
