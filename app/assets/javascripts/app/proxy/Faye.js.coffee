Ext.define('RpcDemo.proxy.Faye',
  extend : 'Ext.data.proxy.Server'
  alias : 'proxy.faye'

  # Properties specific to Faye
  socket : null
  timeout: 120
  retry: 5

  doRequest : (operation, callback, scope) ->
    request = @buildRequest(operation, callback, scope)
    timeout = if Ext.isDefined(request.timeout) then request.timeout else @timeout
    retry = @retry || 5
    url = @url

    if @socket and url != @socket.endpoint
      @subscription.cancel()
      delete @socket
      @socket = null

    if @socket == null
      @socket = new Faye.Client(url,
        timeout: timeout
        retry: retry
      )
      @subscription = @socket.subscribe(@channel, @onSubscription)
      @socket.addExtension(
        outgoing: (message, callback) =>
          message.auth_token = @token if @token
          callback(message)
        incoming: (message, callback) =>
          callback(message)
      )

    records = request.records
    records = Ext.Array.map(request.records, (record) ->
      record.data
    ) if records
    @socket.publish(@channel, records)

    return request

  onSubscription : (message) ->
    console.log(message)

) if Faye
