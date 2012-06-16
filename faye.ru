require 'faye'
require ::File.expand_path('../config/environment',  __FILE__)

Faye::WebSocket.load_adapter('thin')
bayeux = Faye::RackAdapter.new(mount: '/faye', timeout: 45)
run bayeux

# Monitoring of Faye
# http://faye.jcoglan.com/ruby/monitoring.html

# Triggered when a new client connects and is issued with an ID.
bayeux.bind(:handshake) do |client_id|
  Rails.logger.info "[Faye] Client {#{client_id}} handshake."
end

# Triggered when a client subscribes to a channel.
# This does not fire if a /meta/subscribe message is received for a
# subscription that already exists.
bayeux.bind(:subscribe) do |client_id, channel|
  Rails.logger.info "[Faye] Client {#{client_id}} subscribed to #{channel}."
end

# Triggered when a client unsubscribes from a channel.
# This can fire either because the client explicitly sent a /meta/unsubscribe
# message, or because its session was timed out by the server.
bayeux.bind(:unsubscribe) do |client_id, channel|
  Rails.logger.info "[Faye] Client {#{client_id}} unsubscribed from #{channel}."
end

# Triggered when a non-/meta/** message is published.
# Includes the client ID of the publisher (which may be nil), the channel
# the message was sent to and the data payload.
bayeux.bind(:publish) do |client_id, channel, data|
  Rails.logger.info "[Faye] Client {#{client_id}} published data to #{channel}."
  Rails.logger.info data
end

# Triggered when a client session ends, either because it explicitly sent a
# /meta/disconnect message or because its session was timed out by the server.
bayeux.bind(:disconnect) do |client_id|
  Rails.logger.info "[Faye] Client {#{client_id}} disconnected."
end

# rackup faye.ru -E production
