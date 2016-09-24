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

   get '/players/create' do 
    if logged_in?
      @user = current_user 
      erb :'players/create'
    else
      flash[:message] = "You must login to create a player!"
      redirect to '/users/login'
    end
  end

    post '/players/create' do 
    if !params[:position] || !params[:rosters]
      flash[:message] = "You must select one position and one roster for your player!"
      redirect to '/players/create'
    elsif params[:rosters].count > 1 || params[:position].count > 1 
      flash[:message] = "You can only select a single position or roster for your new player!"
      redirect to '/players/create'
    elsif params.values.any? {|el| el.empty?}
      flash[:message] = "Player must have all fields filled out!"
      redirect to '/players/create'
    else
      @player = Player.create(name: params[:name], position: params[:position], salary: params[:salary])
      @roster = Roster.find_by_id(params[:rosters])
      @player.save
      @roster.players << @player
      @roster.save
      flash[:message] = "#{@player.name} created - Added to #{@roster.roster_name}"
      redirect to '/users/index'
    end
  end

  get '/players/index' do
    @player = Player.all  
    erb :'players/index'
  end



end