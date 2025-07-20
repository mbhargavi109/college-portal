class Subject < ApplicationRecord
  belongs_to :department
  has_many :users

  validates :name, presence: true
end
