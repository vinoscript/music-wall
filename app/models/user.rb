class User < ActiveRecord::Base

  has_many :tracks

  validates :email, presence: true, uniqueness: true, length: {minimum: 3, maximum: 40}
  validates :password, presence: true, length: {minimum: 4, maximum: 20}

end