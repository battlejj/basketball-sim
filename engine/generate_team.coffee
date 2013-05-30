generate_player = require './generate_player'

exports = module.exports = (city, nickname, player_type)->
  #right now this simply generates 5 players of a given type
  #for a team, obviously this can be made more robust in the
  #future

  team =
    city: city
    nickname: nickname
    fullname: "#{city} #{nickname}"
    players: []

  for i in [0...5]
    #generate the player and push him to the lineup, just going
    #to create a PG, SG, SF, PF, C
    team.players.push(generate_player(player_type, i + 1))
    #add the team name to the player just as convenience
    team.players[i]['team'] = team.fullname

  return team

