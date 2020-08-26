class User < ActiveRecord::Base
  has_many :artists
  has_many :concerts, through: :artists
  has_secure_password


  validates :email, :password, :username, presence: true
  validates :email, :username, uniqueness: true

  def authenticate(password)
    if self.password == password
      self
    else
      false
    end
  end

end
