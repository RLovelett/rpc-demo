# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/
Ext.Loader.setConfig(
  enabled: false
  disableCaching: true
)

Ext.application(
  name: 'RpcDemo'
  autoCreateViewport: true
  controllers: [
    'RpcDemo.controller.WelcomeController'
  ]
)
