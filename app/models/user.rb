class User < ActiveRecord::Base
  
  # Callbacks
  before_create :encrypt_password
  after_create :password_to_nil
  
  # Relaciones
  has_many :contacts
  
  # Validaciones
  validates :name, :user, :presence => true
  validates_uniqueness_of :name, :user, :case_sensitive => false, 
    :allow_nil => true, :allow_blank => true
  validates_length_of :name, :user, :in => 5..30, :allow_nil => true,
    :allow_blank => true
  validates_length_of :password, :in => 5..128, :allow_nil => true,
    :allow_blank => true
  validates_confirmation_of :password, :if => :is_not_encrypted?
  
  # Método invocado después de haber creado una instancia de la clase
  def password_to_nil
    self.password = nil
  end
  
  def encrypt_password
    self.salt ||= self.create_new_salt
    self.password = User.digest(self.password, self.salt) if is_not_encrypted?
  end

  def create_new_salt
    Digest::SHA512.hexdigest(self.object_id.to_s + rand.to_s)
  end

  def self.digest(string, salt)
    Digest::SHA512.hexdigest("#{salt}-#{string}")
  end

  def is_not_encrypted?
    self.password &&
      (self.password.length < 120 || self.password !~ /^(\d|[a-f])+$/)
  end
  
end
