class Barrel < ActiveRecord::Base
  attr_accessible :RFID, :name, :shape
  
  has_many :spirits


  def self.to_csv(options = {})
      CSV.generate(options) do |csv|
        csv << column_names
        all.each do |barrel|
          csv << barrel.attributes.values_at(*column_names)
        end
      end
    end
  
end
