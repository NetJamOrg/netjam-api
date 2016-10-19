class User < ApplicationRecord
  has_many :clips
  validates :name, presence: true
  validates :email, presence: true
  validates :provider, presence: true
  validates :oauth_uid, presence: true
  # todo reflect this constraint in a migration
  ##    add_index :table_name, [:field1, ... , :fieldn], unique: true
  validates :provider, uniqueness: {scope: :oauth_uid} # provider, uid pair must be unique

  has_many :projects, foreign_key: :owner_id
end
