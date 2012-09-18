class Card < ActiveRecord::Base
  has_and_belongs_to_many :users
  belongs_to :card_set
  mount_uploader :frontpage_image, PictureUploader
  mount_uploader :backpage_image, PictureUploader
  attr_accessible :backpage_image, :backpage_text, :category, :frontpage_image, :frontpage_text, :card_set
end
