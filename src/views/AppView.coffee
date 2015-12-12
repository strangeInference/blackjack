class window.AppView extends Backbone.View
  template: _.template '
    <button class="hit-button">Hit</button> <button class="stand-button">Stand</button>
    <div class="player-hand-container"></div>
    <div class="dealer-hand-container"></div>
  '

  events:
    'click .hit-button': -> @model.get('playerHand').hit()
    'click .stand-button': -> @eval()
      
     
        

  initialize: ->
    @render()
    if @model.get('playerHand').scores()[0] == 21 or @model.get('playerHand').scores()[1] == 21
      @eval()
  render: ->
    @$el.children().detach()
    @$el.html @template()
    @$('.player-hand-container').html new HandView(collection: @model.get 'playerHand').el
    @$('.dealer-hand-container').html new HandView(collection: @model.get 'dealerHand').el

  eval: ->
    alert('hi')
    @model.get('dealerHand').models[0].flip() 
    while @model.get('dealerHand').scores()[1] < 17
      @model.get('dealerHand').hit() 
    if @model.get('dealerHand').scores()[1] > 21
      while @model.get('dealerHand').scores()[0] < 17
        @model.get('dealerHand').hit()
    if @model.get('dealerHand').scores()[0] > 21
      alert('Dealer Busts')
    play = @model.get('playerHand').scores()
    deal = @model.get('dealerHand').scores()
