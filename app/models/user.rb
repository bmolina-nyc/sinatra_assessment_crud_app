class User < ActiveRecord::Base 
  has_many :rosters
  has_secure_password
  validates_presence_of :username, :password

end 