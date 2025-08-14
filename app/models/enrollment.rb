class Enrollment < ApplicationRecord
  belongs_to :course
  belongs_to :student
  has_many :submissions, dependant: :destroy
  has_many :mentor_enrollment_assignments
end
