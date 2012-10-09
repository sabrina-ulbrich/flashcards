class CardSet < ActiveRecord::Base
  has_and_belongs_to_many :users, :join_table=>'card_sets_users'
  has_many :cards
  attr_accessible :id, :name
  
   def getNextCard(currentCard)
    
   # lastCard = currentCard.card_set.last
   # lastId = Integer(lastCard.id)
   # nextId = Integer(currentCard.id) + 1
   # if lastId < nextId
   #   return nil
   # end
   # return Card.find(nextId)
   
   cards = currentCard.card_set.cards
   next_index = cards.index(currentCard) +1
   if(next_index < cards.length)
     cards[next_index]
   else
     nil
   end
  end
end
