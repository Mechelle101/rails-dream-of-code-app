class Course < ApplicationRecord
  belongs_to :coding_class
  belongs_to :trimester
  has_many :enrollments

  delegate :title, to: :coding_class

  # def student_name_list
  #   names_list = []
  #   self.enrollments.each do |enrollment| 
  #     names_list << "#{enrollment.student.first_name} #{enrollment.student.last_name}" 
  #   end
  #   names_list
  # end

  def student_name_list
    enrollments
      .includes(:student)
      .order(:id)
      .map { |e| "#{e.student&.first_name} #{e.student&.last_name}" }
      .compact
  end

# could do it this way
  # def student_email_list
  #   email_list = []
  #   self.enrollments.each do |e|
  #     email_list << "#{e.student.email}"
  #   end
  #   email_list
  # end

# this is more fun, and better for performance
  def student_email_list
    enrollments
      .includes(:student)
      .order(:id)
      .map { |e| e.student&.email }
      .compact
  end
end