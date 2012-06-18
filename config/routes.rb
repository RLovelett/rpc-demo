RpcDemo::Application.routes.draw do
  devise_for :users

  resources :commands, only: [:index, :create]
  resources :tokens, only: [:index, :create, :destroy]

  # The priority is based upon order of creation:
  # first created -> highest priority.

  # Sample of regular route:
  #   match 'products/:id' => 'catalog#view'
  # Keep in mind you can assign values other than :controller and :action

  # Sample of named route:
  #   match 'products/:id/purchase' => 'catalog#purchase', :as => :purchase
  # This route can be invoked with purchase_url(:id => product.id)

  # Sample resource route (maps HTTP verbs to controller actions automatically):
  #   resources :products

  # Sample resource route with options:
  #   resources :products do
  #     member do
  #       get 'short'
  #       post 'toggle'
  #     end
  #
  #     collection do
  #       get 'sold'
  #     end
  #   end

  # Sample resource route with sub-resources:
  #   resources :products do
  #     resources :comments, :sales
  #     resource :seller
  #   end

  # Sample resource route with more complex sub-resources
  #   resources :products do
  #     resources :comments
  #     resources :sales do
  #       get 'recent', :on => :collection
  #     end
  #   end

  # Sample resource route within a namespace:
  #   namespace :admin do
  #     # Directs /admin/products/* to Admin::ProductsController
  #     # (app/controllers/admin/products_controller.rb)
  #     resources :products
  #   end

  # You can have the root of your site routed with "root"
  # just remember to delete public/index.html.
  root to: 'welcome#index'

  # Resque
  mount Resque::Server, at: "/resque"

  # Faye
  faye_server '/faye', timeout: 25 do
    # Monitoring of Faye
    # http://faye.jcoglan.com/ruby/monitoring.html

    # Triggered when a new client connects and is issued with an ID.
    bind(:handshake) do |client_id|
      Rails.logger.info "[#{self.class}] Client {#{client_id}} handshake."
    end

    # Triggered when a client subscribes to a channel.
    # This does not fire if a /meta/subscribe message is received for a
    # subscription that already exists.
    bind(:subscribe) do |client_id, channel|
      Rails.logger.info "[#{self.class}] Client {#{client_id}} subscribed to #{channel}."
    end

    # Triggered when a client unsubscribes from a channel.
    # This can fire either because the client explicitly sent a /meta/unsubscribe
    # message, or because its session was timed out by the server.
    bind(:unsubscribe) do |client_id, channel|
      Rails.logger.info "[#{self.class}] Client {#{client_id}} unsubscribed from #{channel}."
    end

    # Triggered when a non-/meta/** message is published.
    # Includes the client ID of the publisher (which may be nil), the channel
    # the message was sent to and the data payload.
    bind(:publish) do |client_id, channel, data|
      Rails.logger.info "[#{self.class}] Client {#{client_id}} published data to #{channel}."
      Rails.logger.info data
    end

    # Triggered when a client session ends, either because it explicitly sent a
    # /meta/disconnect message or because its session was timed out by the server.
    bind(:disconnect) do |client_id|
      Rails.logger.info "[#{self.class}] Client {#{client_id}} disconnected."
    end

    # Routing
    map '/commands/**' => CommandsController
    #map :default       => :block

    # Authentication
    class ServerAuthentication
      #def incoming(message, callback)
        #user = User.find_by_authentication_token message['auth_token']
        #Rails.logger.info "[#{self.class}] #{message.inspect}"
        #Rails.logger.info "[#{self.class}] #{user}"
        #if user.nil?
          #message['error'] = 'Invalid user token.'
        #end
        #callback.call(message)
      #end
    end
    add_extension(ServerAuthentication.new)

  end

  # See how all your routes lay out with "rake routes"

  # This is a legacy wild controller route that's not recommended for RESTful applications.
  # Note: This route will make all actions in every controller accessible via GET requests.
  # match ':controller(/:action(/:id))(.:format)'
end
