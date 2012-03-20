class Contract
  include Validatable
  attr_accessor :nombre, :dni, :email, :telefono, :interesado_en, :comentarios
  
  validates_presence_of :nombre, :dni, :telefono, :email
  validates_numericality_of :dni, :only_integer => true
  validates_format_of :email, :with => /^([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})$/i
  validates_length_of :nombre, :email, :telefono, :maximum => 30
  validates_length_of :comentarios, :maximum => 255
  
  def initialize(attributes = {})
    self.nombre = attributes[:nombre]
    self.dni = attributes[:dni]
    self.telefono = attributes[:telefono]
    self.interesado_en = attributes[:interesado_en]
    self.email = attributes[:email]
    self.comentarios = attributes[:comentarios]
  end
  
end