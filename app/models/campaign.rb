class Campaign < ActiveRecord::Base
  
  # Validaciones
  validates :date, :presence => true
  validates_date :date, :allow_nil => true, :allow_blank => true
  
end
