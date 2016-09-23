require './config/environment'
require 'rack-flash'

class UsersController < ApplicationController 

  use Rack::Flash

  configure do
    set :public_folder, 'public'
    set :views, 'app/views'
    enable :sessions
    set :session_secret, "secret"
  end

  get '/login' do 
    erb :'users/login'
  end

  post '/signup' do 
    if params.values.any? {|el| el.empty?}
      flash[:message] = "You need to enter all fields to signup!"
      redirect to '/signup'
    else
      @user = User.create(username: params[:username], password: params[:password])
      @user.save 
      session[:id] = @user.id
      redirect to '/rosters/index'
    end
  end

  post '/login' do 
    @user = User.find_by(username: params[:username])
  
    if @user && @user.authenticate(params[:password])
      session[:id] = @user.id
      redirect to '/tweets'
    else
      flash[:message] = "Login information incorrect"
      redirect '/login'
    end
  end

  get '/logout' do 
    session.clear
    redirect to '/login'
  end




end