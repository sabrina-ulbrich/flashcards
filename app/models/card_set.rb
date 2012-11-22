class CardSet < ActiveRecord::Base
  has_and_belongs_to_many :users, :join_table=>'card_sets_users'
  has_many :cards
  attr_accessible :id, :name
  
  attr_accessor :known, :unknown, :total
  
   def getNextCard(currentCard)
    cards = currentCard.card_set.cards
    next_index = cards.index(currentCard) +1
    if(next_index < cards.length)
      cards[next_index]
    else
      nil
    end
  end
  
end
