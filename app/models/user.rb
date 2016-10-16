class User < ApplicationRecord
  has_many :clips
  validates :name, presence: true
  validates :email, presence: true
end
