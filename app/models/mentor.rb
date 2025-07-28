class Mentor < ApplicationRecord
  has_many :mentor_enrollment_assignments
  has_many :enrollments, through: :mentor_enrollment_assignments
end
