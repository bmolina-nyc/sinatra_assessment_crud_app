class CreatePlayerRosters < ActiveRecord::Migration
  def change
    create_table :player_rosters do |t|
      t.integer :roster_id
      t.integer :player_id
    end
  end
end
