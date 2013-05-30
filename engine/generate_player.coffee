#Utility function, just returns a random number to distinguish generated players
getRandomPlayerId = ->
  return Math.floor((1+Math.random())*0x10000).toString().substring(1)

exports = module.exports = (type, position)->
  #For now, we will only generate 2 possible types, 'average'
  #and 'random' players. This can be expanded later as more needs
  #arise. 'average' is all 50's, 'random' is totally random 1-100 ratings

  #We need a list of attributes to generate for the player.
  #again this can be added to as we go along, 50 will be considered
  #perfectly average, 25 will be considered poor, 75 above average
  #and 100 will be elite, we really don't want anyone below 25 skill
  #level in any category, they would not be playing basketball most likely

  #try to keep attributes in alpha order, easier to see what's here and isn't
  #if they are somewhat ordered.
  skill_attributes = [
    "defensive_awareness"
    , "hands"
    , "jumping"
    , "offensive_awareness"
    , "strength"
  ]

  player =
    name: "Player #{getRandomPlayerId()}"
    natural_pos: position
    current_pos: position

  switch type
    when "random"
      for attribute in skill_attributes
        player[attribute] = Math.floor(Math.random() * 100) + 1
    when "average"
      for attribute in skill_attributes
        player[attribute] = 50
    else
      for attribute in skill_attributes
        player[attribute] = 50

  return player
