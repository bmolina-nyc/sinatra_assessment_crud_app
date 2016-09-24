require './config/environment'
require 'rack-flash'

class ApplicationController < Sinatra::Base

  use Rack::Flash

  configure do
    set :public_folder, 'public'
    set :views, 'app/views'
    enable :sessions
    set :session_secret, "secret"
  end

  # this is an index page 
  # should expect logic for redirects to login, and signup
  get '/' do   

    erb :index
  end
  
  get '/signup' do 
    if logged_in?
      redirect to '/users/index'
    else
      erb :'/signup'
    end
  end

helpers do
    def logged_in?
      !!session[:id]
    end

    def current_user
      User.find_by_id(session[:id])
    end
  end





end