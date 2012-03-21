class Contact < ActiveRecord::Base
  default_scope :order => 'date'

  # Relaciones
  belongs_to :contact_state
  belongs_to :user
  
  accepts_nested_attributes_for :contact_state
  
  # Validaciones
  validates :date, :name, :number, :presence => true
  validates_length_of :name, :locality, :comment, :maximum => 255
  validates_numericality_of :number, :only_integer => true, :allow_nil => true,
    :allow_blank => true, :greater_than => 0, :less_than => 5000000
  validates_uniqueness_of :number, :allow_nil => true, :allow_blank => true
  validates_date :date, :allow_nil => true, :allow_blank => true
    
end
