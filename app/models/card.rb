class Card < ActiveRecord::Base
  mount_uploader :frontpage_image, PictureUploader
  mount_uploader :backpage_image, PictureUploader
  attr_accessible :backpage_image, :backpage_text, :category, :frontpage_image, :frontpage_text, :known
end
