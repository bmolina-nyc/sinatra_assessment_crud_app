class Player < ActiveRecord::Base 
  has_many :player_rosters
  has_many :rosters, through: :player_rosters

  def slug 
    self.name.split.map { |el| el.downcase}.join("-")
  end


  def Player.find_by_slug(slug)  # need the string you undid above to revert to its original object based on the slug name

    Player.all.detect do |player|
      player.slug == slug 
    end
  end
end 