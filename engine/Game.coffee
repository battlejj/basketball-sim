Game = ()->
  @possession = null
  @teams = []
  @

Game.prototype.addTeam = (team)->
  if @teams.length < 2
    @teams.push(team)
  else
    throw "Cannot add a 3rd team to the game."

Game.prototype.jumpBall = ->
  #stub function right now, just gives 50/50 chance to win first posession
  @possession = Math.round(Math.random())
  return @possession

require './weighted_probability'
require './rebound'

exports = module.exports = Game