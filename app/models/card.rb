class Card < ActiveRecord::Base
  attr_accessible :backpage_image, :backpage_text, :category, :frontpage_image, :frontpage_text, :known
end
