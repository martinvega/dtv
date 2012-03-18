class ContactState < ActiveRecord::Base

  # Relaciones
  has_many :contacts
  
  # Validaciones
  validates :state, :presence => true
  validates_uniqueness_of :state, :allow_nil => true, :allow_blank => true
  validates_length_of :state, :maximum => 255, :allow_blank => true,
    :allow_nil => true

end
