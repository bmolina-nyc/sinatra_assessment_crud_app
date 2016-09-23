class PlayerRoster < ActiveRecord::Base 
  belongs_to :player
  belongs_to :roster
end 