class Player < ActiveRecord::Base 
  has_many :player_rosters
  has_many :rosters, through: :player_rosters
end 