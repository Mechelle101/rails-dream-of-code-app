class Enrollment < ApplicationRecord
  belongs_to :course
  belongs_to :student
  has_many :mentor_enrollment_assignments
  has_many :mentors, through: :mentor_enrollment_assignments
end
