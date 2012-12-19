class User < ActiveRecord::Base
  has_and_belongs_to_many :known_cards, :class_name => "Card"
  has_and_belongs_to_many :card_sets
  has_secure_password
  validates_presence_of :password_digest, :on => :create
  validates :name, :presence => true, :uniqueness => true, :on => :create
  validates :password, :presence =>true, :length => { :minimum => 5, :maximum => 40 }, :confirmation =>true, :on => :create
  validates_presence_of :password_confirmation, :on => :create
  attr_accessible  :id,  :name, :password, :password_confirmation
  
end
