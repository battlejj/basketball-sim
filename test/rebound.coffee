should = require 'should'
expect = require('chai').expect
Game = require '../engine/rebound'
generate_team = require '../engine/generate_team'

describe('testing rebounding algorithms', ->

  describe('test rebounding 2000 rebounds with random players', ->
    it('should deviate up to a few % from the 27% offensive rebound avg', (done)->
      #create a new game instance
      game = new Game()

      #generate miami heat
      miami = generate_team('Miami', 'Heat', 'random')
      #generate indiana pacers
      indy = generate_team('Indiana', 'Pacers', 'random')

      #add teams to the game
      game.addTeam(miami)
      game.addTeam(indy)

      #determine initial possession
      possession = if game.jumpBall() then indy else miami

      #struct for sim stats
      totals =
        o: 0
        d: 0
        indy:
          o: 0
          d: 0
        miami:
          o: 0
          d: 0

      #loop through the 2000 rebounds and keep track of stats
      for i in [0...2000]
        rebound = game.rebound()
        if not totals.hasOwnProperty(rebound.player.name)
          totals[rebound.player.name] =
            o: 0
            d: 0
        if rebound.type is "o"
          totals[rebound.player.name]['o']++
          totals.o++
          if rebound.player.team is miami.fullname
            totals.miami.o++
          else
            totals.indy.o++
        else
          totals[rebound.player.name]['d']++
          totals.d++
          if rebound.player.team is miami.fullname
            totals.miami.d++
          else
            totals.indy.d++

      #calculate defensive rebound ratio
      totals.ratio = totals.o / (totals.o + totals.d)

      #report the stats
      console.log(totals)

      done()
    )
  )

  describe('test rebounding 2000 rebounds with completely average players', ->
    it('should deviate very little from 27% offensive rebound avg', (done)->
      #create a new game instance
      game = new Game()

      #generate miami heat
      miami = generate_team('Miami', 'Heat', 'average')
      #generate indiana pacers
      indy = generate_team('Indiana', 'Pacers', 'average')

      #add teams to the game
      game.addTeam(miami)
      game.addTeam(indy)

      #determine initial possession
      possession = if game.jumpBall() then indy else miami

      #struct for sim stats
      totals =
        o: 0
        d: 0
        indy:
          o: 0
          d: 0
        miami:
          o: 0
          d: 0

      #loop through the 2000 rebounds and keep track of stats
      for i in [0...2000]
        rebound = game.rebound()
        if not totals.hasOwnProperty(rebound.player.name)
          totals[rebound.player.name] =
            o: 0
            d: 0
        if rebound.type is "o"
          totals[rebound.player.name]['o']++
          totals.o++
          if rebound.player.team is miami.fullname
            totals.miami.o++
          else
            totals.indy.o++
        else
          totals[rebound.player.name]['d']++
          totals.d++
          if rebound.player.team is miami.fullname
            totals.miami.d++
          else
            totals.indy.d++

      #calculate defensive rebound ratio
      totals.ratio = totals.o / (totals.o + totals.d)

      #report the stats
      console.log(totals)
      done()
    )
  )

)