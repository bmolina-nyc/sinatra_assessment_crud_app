class Player < ActiveRecord::Base 
  belongs_to :user
  has_many :player_rosters
  has_many :rosters, through: :player_rosters
end 