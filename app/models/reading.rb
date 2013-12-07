class Reading < ActiveRecord::Base
  attr_accessible :date, :liters, :measurement
  belongs_to :spirit
end
