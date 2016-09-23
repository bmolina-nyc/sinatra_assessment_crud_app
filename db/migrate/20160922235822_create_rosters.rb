class CreateRosters < ActiveRecord::Migration
  def change
    create_table :rosters do |t|
      t.string :roster_name
      t.integer :user_id
    end
  end
end
