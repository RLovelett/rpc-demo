Logger =
  outgoing: (message, callback) ->
    tokenStore = Ext.getStore('Token')
    token = undefined
    if tokenStore
      token = tokenStore.first()
      message.auth_token = token.get('token') if token

    callback(message) if token

Ext.define('RpcDemo.controller.WelcomeController',
  extend: 'Ext.app.Controller'
  init: () ->
    tokenStore    = Ext.create('RpcDemo.store.Tokens')
    tokenStore.on('load', (store, records, successful, eOptions) ->
      if(successful)
        client = new Faye.Client('http://localhost:9292/faye')
        client.addExtension(Logger)
        client.subscribe('/commands', (message) ->
          console.log(message)
        )
    )

    commandsStore = Ext.create('RpcDemo.store.Commands')
)
