class Roster < ActiveRecord::Base 
  belongs_to :user
  has_many :player_rosters
  has_many :players, through: :player_rosters
end 