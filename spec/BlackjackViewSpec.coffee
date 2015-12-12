assert = chai.assert

describe "Dealer behavior", -> 
  
  it 'should start with 2 cards', ->
    collection = new Deck()
    hand = new Hand [collection.pop().flip(), collection.pop()], collection, true
    assert.strictEqual hand.length, 2
  it 'first card should not be revealed', ->
    collection = new Deck()
    hand = new Hand [collection.pop().flip(), collection.pop()], collection, true
    assert.strictEqual hand.first().get('revealed'), false
  it 'hand should be that of the dealer', ->
    collection = new Deck()
    hand = new Hand [collection.pop().flip(), collection.pop()], collection, true
    assert.strictEqual hand.isDealer, true
  it 'after stand, dealer should hit until its best score is greater or equal to 17', ->
    appView = new AppView(model: new App())
    appView.dealerHit()
    assert.strictEqual appView.model.get('dealerHand').bestScore() >= 17, true


describe "Player behavior", -> 
  
  it 'should start with 2 cards', ->
    collection = new Deck()
    hand = new Hand [collection.pop(), collection.pop()], collection
    assert.strictEqual hand.length, 2
  it 'both cards should be revealed', ->
    collection = new Deck()
    hand = new Hand [collection.pop(), collection.pop()], collection, true
    assert.strictEqual hand.first().get('revealed'), true
  it 'hand should be that of the player', ->
    collection = new Deck()
    hand = new Hand [collection.pop().flip(), collection.pop()], collection
    assert.strictEqual hand.isDealer, undefined