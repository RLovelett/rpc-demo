Ext.define('RpcDemo.controller.WelcomeController',
  extend: 'Ext.app.Controller'
  init: () ->
    tokenStore    = Ext.create('RpcDemo.store.Tokens',
      listeners:
        load:
          fn: () ->
            commands = Ext.create('RpcDemo.store.Commands')
            commands.proxy.token = arguments[1][0].get('token')
            commands.load()
    )

)
