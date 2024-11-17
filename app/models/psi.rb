class Psi < ApplicationRecord
  validates :crp, presence: true, uniqueness: true
  belongs_to :user
end
