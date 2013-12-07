class Spirit < ActiveRecord::Base
  attr_accessible :name
  belongs_to :barrel
  has_many :readings
  has_many :comments
end
