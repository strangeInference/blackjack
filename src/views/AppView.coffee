class window.AppView extends Backbone.View
  template: _.template '
    <button class="hit-button">Hit</button> <button class="stand-button">Stand</button>
    <div class="player-hand-container"></div>
    <div class="dealer-hand-container"></div>
  '

  events:
    'click .hit-button': -> @model.get('playerHand').hit() @checkBust()
    'click .stand-button': -> @eval()
  
     
        

  initialize: ->
    @render()
    if @model.get('playerHand').scores()[0] == 21 or @model.get('playerHand').scores()[1] == 21
      @eval()
    @model.get('playerHand').on('blackjack', @eval, @)
    @model.get('playerHand').on('checkBust', @checkBust, @)
    @model.get('dealerHand').on('checkBust', @checkBust, @)
  render: ->
    @$el.children().detach()
    @$el.html @template()
    @$('.player-hand-container').html new HandView(collection: @model.get 'playerHand').el
    @$('.dealer-hand-container').html new HandView(collection: @model.get 'dealerHand').el

  eval: ->
    @model.get('dealerHand').models[0].flip() 
    while @model.get('dealerHand').scores()[1] < 17
      @model.get('dealerHand').hit() 
    if @model.get('dealerHand').scores()[1] > 21
      while @model.get('dealerHand').scores()[0] < 17
        @model.get('dealerHand').hit()
    player = @model.get('playerHand').bestScore()
    dealer = @model.get('dealerHand').bestScore()
    @checkBust()
    if dealer <= 21 
      if player > dealer 
        alert('Player Wins!')
        @model.reset()
        @render()
      else if dealer > player
        alert('Dealer Wins')
        @model.reset()
        @render()
      else
        alert("It's a tie")
        @model.reset()
        @render()

  checkBust: ->
    if @model.get('playerHand').bestScore() > 21
      alert('Player Busts')
      @model.reset()
      @render()
    if @model.get('playerHand').bestScore() == 21
      @eval()
    if @model.get('dealerHand').bestScore() > 21
      alert('Dealer Busts')
      @model.reset()
      @render()