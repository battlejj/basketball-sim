_ = require 'underscore'
Game = require './Game'
weighted_probability = require './weighted_probability'

#Some variables that will likely be propertys of the sim model eventually
#but for now they relate to rebounding and sim doesnt exist. so here they are
DEF_REBOUND_BASE =
  1: 20
  2: 20
  3: 50
  4: 90
  5: 120

OFF_REBOUND_BASE =
  1: 5
  2: 5
  3: 20
  4: 30
  5: 50

Game.prototype.rebound = ->
  #determine which team is on offense and which is on defense
  switch @possession
    when 0
      offense = @teams[0]
      defense = @teams[1]
    else
      offense = @teams[1]
      defense = @teams[0]

  #arrays we will use to pass to weighted probability function
  rebounders = []
  rebound_chances = []

  for idx in [0..1]
    if idx is 0
      players = offense.players
      rebound_base = OFF_REBOUND_BASE
    else
      players = defense.players
      rebound_base = DEF_REBOUND_BASE
    for player in players
      #start with the base probability for the players position
      rebound_chance = rebound_base[player.current_pos]

      #penalize the player if he is out of his natural position
      #right now its just a flat 15% base pentalty
      #TODO: make this more robust to handle players on the wing or PF/C hybrids
      unless player.natural_pos is player.current_pos
        rebound_chance = Math.round(rebound_chance * 0.85)

      #Mods assume that 50 means no advantage, below 50 is a disavantage(negative mod) and above 50 is an advantage
      #(positive mod), how much of a factor these are can be tweaked, just picking some numbers for now
      #multiplying by chance, probably needs to be modified to average offense/defensive rebound chance, it seems
      #like multiplying by flat base chance might create some REALLY dominating defensive rebounders and make a large
      #gap between offensive/defensive rebounds (more so than already exist)
      if idx is 0
        awareness_mod = Math.round((((player.offensive_awareness - 50)/100) * rebound_chance) * 2)
      else
        awareness_mod = Math.round((((player.defensive_awareness - 50)/100) * rebound_chance) * 2)
      hands_mod = Math.round((((player.hands - 50)/100) * rebound_chance) * 1.5)
      jump_mod = Math.round((((player.jumping - 50)/100) * rebound_chance) * 1.2)
      strength_mod = Math.round((((player.strength - 50)/100) * rebound_chance) * 1.2)

      #add the modifiers to the base chance
      rebound_chance = rebound_chance + awareness_mod + hands_mod + jump_mod + strength_mod

      rebounders.push(player)
      rebound_chances.push(rebound_chance)

  rebound =
    player: weighted_probability(rebounders, rebound_chances)
    possession: @possession

  #if the defense got the rebound, change possession
  if rebound.player.team is defense.fullname
    @possession = if @possession then 0 else 1
    rebound.type = "d"
    rebound.possession = @possession
  else
    rebound.type = "o"
  return rebound

exports = module.exports = Game