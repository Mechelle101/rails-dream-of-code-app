class Student < ApplicationRecord
  has_many :enrollments
  # I'm going to add this here for my own reference. 
  # this says from student to all the courses they're enrolled in
  has_many :courses, through: :enrollments

  validates :first_name, :last_name, :email, presence: true
  validates :email, uniqueness: true

  def full_name
    "#{first_name} #{last_name}"
  end
end
