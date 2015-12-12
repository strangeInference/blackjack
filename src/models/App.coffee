# TODO: Refactor this model to use an internal Game Model instead
# of containing the game logic directly.
class window.App extends Backbone.Model
  initialize: ->
    @set 'deck', deck = new Deck()
    @set 'playerHand', deck.dealPlayer()
    @set 'dealerHand', deck.dealDealer()

  reset: ->
    if @get('deck').length <= 4
    
      @set('deck', new Deck())
    @set 'playerHand', @get('deck').dealPlayer()  
    @set 'dealerHand', @get('deck').dealDealer()  

