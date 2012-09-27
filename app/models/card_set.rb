class CardSet < ActiveRecord::Base
  has_and_belongs_to_many :users, :join_table=>'card_sets_users'
  has_many :cards
  attr_accessible :id, :name
end
