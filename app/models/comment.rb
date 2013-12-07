class Comment < ActiveRecord::Base
  attr_accessible :author, :content, :date
  belongs_to :spirit
end
