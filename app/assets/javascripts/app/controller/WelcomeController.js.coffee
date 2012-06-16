Ext.define('RpcDemo.controller.WelcomeController',
  extend: 'Ext.app.Controller'
  init: () ->
    tokenStore    = Ext.create('RpcDemo.store.Tokens')
    commandsStore = Ext.create('RpcDemo.store.Commands')

    # Connect to Faye
    client = new Faye.Client('http://localhost:9292/faye')
    client.subscribe('/commands', (message) ->
      console.log(message)
    )
)
