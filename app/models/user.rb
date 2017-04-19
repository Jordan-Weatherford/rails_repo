class User < ApplicationRecord
  has_secure_password

  has_many :owners
  has_many :events, through: :owners
end
