class CreateCommands < ActiveRecord::Migration
  def change
    create_table :commands do |t|
      t.string :name
      t.text :arguments
      t.string :resque_id

      t.timestamps
    end
  end
end
