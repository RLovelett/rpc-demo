Ext.define('RpcDemo.proxy.Faye',
  extend : 'Ext.data.proxy.Server'
  alias : 'proxy.faye'

  # Properties specific to Faye
  socket : null
  timeout: 120
  retry: 5

  subscriptions:
    create: undefined
    read: undefined
    update: undefined
    destroy: undefined

  actionMethods:
    create:  '/create'
    read:    ''
    update:  '/update'
    destroy: '/destroy'

  doRequest : (operation, callback, scope) ->
    request = @buildRequest(operation, callback, scope)
    timeout = if Ext.isDefined(request.timeout) then request.timeout else @timeout
    retry = @retry || 5
    url = @url

    if @socket and url != @socket.endpoint
      @closeAllChannels()
      delete @socket
      @socket = null

    if @socket == null
      @socket = new Faye.Client(url,
        timeout: timeout
        retry: retry
      )
      @socket.addExtension(
        outgoing: (message, callback) =>
          message.auth_token = @token if @token
          callback(message)
        incoming: (message, callback) =>
          callback(message)
      )
      tempCallback = @createRequestCallback(request, operation, callback, scope)
      channel = @stripTrailingSlash(@channel)
      @subscriptions.create  = @socket.subscribe("#{channel}#{@actionMethods.create}", tempCallback)
      @subscriptions.read    = @socket.subscribe("#{channel}#{@actionMethods.read}", tempCallback)
      @subscriptions.update  = @socket.subscribe("#{channel}#{@actionMethods.update}", tempCallback)
      @subscriptions.destroy = @socket.subscribe("#{channel}#{@actionMethods.destroy}", tempCallback)

    records = request.records
    records = Ext.Array.map(request.records, (record) ->
      record.data
    ) if records

    return request

  closeAllChannels: () ->
    Ext.Object.each(@subscriptions, (key, value, me) ->
      value.close()
    )

  stripTrailingSlash: (str) ->
    if str.substr(-1) == '/'
      return str.substr(0, str.length - 1)
    return str

  createRequestCallback: (request, operation, callback, scope) ->
    me = @

    (data) ->
      me.processResponse(true, operation, request, data, callback, scope)

) if Faye
