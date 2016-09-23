require './config/environment'
require 'rack-flash'

class RostersController < ApplicationController 

  # this is where a login gets routed
  get '/rosters/index' do 
    if current_user
      @user = current_user
      erb :'/rosters/index' 
    else
      flash[:message] = "You must be logged in to see a roster page!"
      redirect to '/login'
    end
  end

  use Rack::Flash

  configure do
    set :public_folder, 'public'
    set :views, 'app/views'
    enable :sessions
    set :session_secret, "secret"
  end



end