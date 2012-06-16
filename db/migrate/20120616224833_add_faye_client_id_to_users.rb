class AddFayeClientIdToUsers < ActiveRecord::Migration
  def change
    add_column :users, :faye_client_id, :string
    add_index  :users, :faye_client_id
  end
end
