class CreatePlayers < ActiveRecord::Migration
  def change
    create_table :players do |t|
      t.string :name
      t.string :position
      t.integer :salary
      t.integer :roster_id
    end
  end
end
