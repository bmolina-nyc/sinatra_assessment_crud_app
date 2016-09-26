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

    get '/players/index' do
    @players = Player.all  
    erb :'players/index'
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

  get '/players/:slug' do 
    @player = Player.find_by_slug(params[:slug])
    erb :'/players/show'
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
      @roster = Roster.find_by_id(params[:rosters])
      @player = Player.create(name: params[:name], position: params[:position].join, salary: params[:salary], roster_id: @roster.id)
      @player.rosters << @roster
      @player.save
  
      flash[:message] = "#{@player.name} created - Added to #{@roster.roster_name}"
      redirect to "/players/#{@player.slug}"
    end
  end

  get '/players/:slug/edit' do 
    @player = Player.find_by_slug(params[:slug])

    if current_user.id != @player.rosters.last.user_id
      flash[:message] = "You can't edit a player you didn't create or a player not on your team!"
      redirect to '/players/index'
    else
      @user = current_user
      @current_position = @player.position
      erb :'players/edit'
    end
  end

  post '/players/:slug/edit' do
    @player = Player.find_by_slug(params[:slug])

     if !params[:position] || !params[:rosters]
      flash[:message] = "When editing, You must select one position and one roster for your player!"
      redirect to "/players/#{@player.slug}/edit"
     elsif params[:rosters].count > 1 || params[:position].count > 1 
      flash[:message] = "When editing, You can only select a single position or roster for your new player!"
      redirect to "/players/#{@player.slug}/edit"
     elsif params[:name].empty? || params[:salary].empty?
      flash[:message] = "Edited Player must have all fields filled out!"
      redirect to "/players/#{@player.slug}/edit"
      else
      
        # get the player out of the old roster 
        @roster_old = Roster.find(@player.roster_id)
        @roster_old.players.delete(@player.id)
        @roster_old.save 

        #get the player into the new roster and update any params accordingly 
        @roster_new = Roster.find_by_id(params[:rosters])
        @player.name = params[:name]
        @player.position = params[:position].join
        @player.salary =  params[:salary]
        @player.rosters << @roster_new 
        @player.roster_id = @roster_new.id
      
        @player.save    

        flash[:message] = "#{@player.name} updated"
      end
    redirect to "/players/#{@player.slug}"
  end

  delete '/players/:slug/delete' do 
    @player = Player.find_by_slug(params[:slug])
    @player.delete

    flash[:message] = "The selected player was deleted"
    redirect to '/users/index'
  end 



end