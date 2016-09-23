NOTES

## Goal of this project 

- Create logins that allow a User to make a Roster and make Players for that Roster
- A user can edit a Roster and Edit a Players stats, if they created that player or stat
- Make these players viewable and have their own individual pages - want to give them an average, homeruns, and rbi stats
- A Roster has many Pitchers and Fielders
- A Pitcher and a Fielder belong to a Roster


A User has many Rosters
A Roster belongs to a User (need a user_id)
A Roster has many Players
A Player has many Rosters  (cuz we are going to trade players between rosters - will set it up that this action can happen automantically across Users)

Will create the following tables
create_users
create_rosters
create_players
create_player_rosters it will have a Roster ID and a Player ID

