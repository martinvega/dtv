class Campaign < ActiveRecord::Base
  
  # Validaciones
  validates :month, :year, :presence => true
  validates_numericality_of :month, :only_integer => true, :greater_than => 0,
    :less_than => 13, :allow_nil => true, :allow_blank => true
  validates_numericality_of :year, :only_integer => true, :greater_than => 1990,
    :less_than => 2050, :allow_nil => true, :allow_blank => true
  
end
