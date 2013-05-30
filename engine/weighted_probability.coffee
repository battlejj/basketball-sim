_ = require 'underscore'

exports = module.exports = (choices, weights) ->
  #This will be our deck of possibilities
  deck = []

  #We need to make sure both our arguments are arrays, and they have equal # of elements
  #otherwise throw an error
  if Array.isArray(choices) and Array.isArray(choices) and (choices.length is weights.length)
    #for each weight, round to the nearest 1 in case floats were passed
    for weight, idx in weights
      weight = Math.round(weight)

      #insert the index value into the deck equal to the number of times in the weight
      for i in [0..weight]
        deck.push(idx)

    #all our indexes are now entered into the deck the appropriate # of times, shuffle the deck
    deck = _.shuffle(deck)

    #make a random choice from the deck
    choice = deck[Math.floor(Math.random() * deck.length)]

    #return the appropriate choice
    return choices[choice]
  else
    throw 'Error when calling weighted_probability. Expected 2 arrays of equal length as arguments. Received: ' +
      JSON.stringify(arguments)