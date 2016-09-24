class Roster < ActiveRecord::Base 
  belongs_to :user
  has_many :player_rosters
  has_many :players, through: :player_rosters

  def slug 
    self.roster_name.split.map { |el| el.downcase}.join("-")
  end


  def Roster.find_by_slug(slug)  # need the string you undid above to revert to its original object based on the slug name

    Roster.all.detect do |roster|
      roster.slug == slug 
    end
  end
end 