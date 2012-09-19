class User < ActiveRecord::Base
  has_and_belongs_to_many :unknown_cards, :class_name => "Card"
  has_and_belongs_to_many :known_cards, :class_name => "Card"
  has_and_belongs_to_many :card_sets
  attr_accessible  :id,  :name, :password
  
  def check_password?(password)
     return (password == self.password) 
  end
end
