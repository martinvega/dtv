class Contract
  include Validatable
  attr_accessor :nombre, :dni, :email, :telefono, :interesado_en, :comentarios
  
  validates_presence_of :nombre, :dni, :telefono, :email, :message => 'no puede estar en blanco'
  validates_numericality_of :dni, :only_integer => true, :message => 'debe ser un número'
  validates_format_of :email, :with => /^([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})$/i, 
    :message => 'el formato no es válido'
  validates_length_of :nombre, :email, :telefono, :maximum => 30, :message => 'es demasiado largo'
  validates_length_of :comentarios, :maximum => 255, :message => 'es demasiado largo'
  
  def initialize(attributes = {})
    self.nombre = attributes[:nombre]
    self.dni = attributes[:dni]
    self.telefono = attributes[:telefono]
    self.interesado_en = attributes[:interesado_en]
    self.email = attributes[:email]
    self.comentarios = attributes[:comentarios]
  end
  
end