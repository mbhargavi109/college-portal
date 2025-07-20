class Department < ApplicationRecord
  has_many :users
  has_many :subjects
  
  validates :name, presence: true, uniqueness: true
end
