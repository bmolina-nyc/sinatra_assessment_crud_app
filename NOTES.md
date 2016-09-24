NOTES

## Goal of this project 

- Create logins that allow a User to make a Roster and make Players for that Roster
- A user can edit a Roster and Edit a Players if they created it.
- Make these players viewable and have their own individual pages
- A User has many Rosters
- A roster belongs to a User (so it needs a user_id)
- A Roster has many Players
- A Player has many Rosters (because it can be traded between rosters)
- I'll allow Users to automatically trade Players and Rosters to other teams for now. But I will ban Update and Delete actions unless you are the "owning" User


Will create the following tables
create_users
create_rosters
create_players
create_player_rosters it will have a Roster ID and a Player ID



# done 
Main Index Page
User login and User signup
User Index Page - User can see owned Rosters and has the option to CREATE or READ Rosters or Players

UPDATE goals
- A user can see and click into all selectable Rosters that appear in the users/index and at the rosters/index page
- rosters/show page will display Roster name, and all current Players
- There needs to be an UPDATE form route that allows us to edit the Player or Roster, and allow us to Change the Players Info
- If you didn't create the player or roster, you can't UPDATE it.
