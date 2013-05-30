should = require 'should'
expect = require('chai').expect
generate_team = require '../engine/generate_team'

#TODO: make actual tests
#I will eventually right a real test for these, but right now I just
#wanted to make sure that they are creating teams correctly. They are.

describe('test generating teams', ->

  describe('generate a team of random players', ->
    it('should generate a team of players with random attributes', (done)->
      team = generate_team('Miami', 'Heat', 'random')
      #console.log(team)
      done()
    )
  )

  describe('generate a team of average players', ->
    it('should generate a team of players with average attributes', (done)->
      team = generate_team('Miami', 'Heat', 'average')
      #console.log(team)
      done()
    )
  )

)