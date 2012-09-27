class User < ActiveRecord::Base
  has_and_belongs_to_many :unknown_cards, :class_name => "Card"
  has_and_belongs_to_many :known_cards, :class_name => "Card"
  has_and_belongs_to_many :card_sets
  has_secure_password
  validates_presence_of :password_digest, :on => :create
  attr_accessible  :id,  :name, :password
  
end
