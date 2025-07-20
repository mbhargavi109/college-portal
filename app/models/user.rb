class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  belongs_to :department
  belongs_to :subject

  validates :department, :subject, presence: true
  validates :name, :role, presence: true

  validates :roll_number, presence: true, if: -> { role == 'student' }

  ROLES = %w[student teacher]

  validates :role, inclusion: { in: ROLES }

  def student?
    role == "student"
  end

  def teacher?
    role == "teacher"
  end
end
