class User < ApplicationRecord
  validates :name, presence: true
  validates :email, presence: true, uniqueness: true
  validates :password, presence: true, on: :create
  has_secure_password
  has_many :psis, dependent: :destroy
end
