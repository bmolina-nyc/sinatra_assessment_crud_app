require './config/environment'
require 'rack-flash'

class PlayersController < ApplicationController 

  use Rack::Flash

  configure do
    set :public_folder, 'public'
    set :views, 'app/views'
    enable :sessions
    set :session_secret, "secret"
  end



end