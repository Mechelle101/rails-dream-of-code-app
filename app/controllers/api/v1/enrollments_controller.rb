class Api::V1::EnrollmentsController < ApplicationController
  # if course id is not found, return json 404
rescue_from ActiveRecord::RecordNotFound do
  render json: { error: "course not found" }, status: :not_found
end
  
  def index
    # find the course by the course_id parameter
    course = Course.find(params[:course_id])

    # load students to avoid N+1 issues
    enrollments = course.enrollments.includes(:student)

    # build enrollment data
    enrollments_data = enrollments.map do |enrollment|
      student = enrollment.student
      {
        id:               enrollment.id,
        studentId:        student.id,
        studentFirstName: student.first_name,
        studentLastName:  student.last_name,
        finalGrade:       safe_final_grade(enrollment)
      }
    end

    render json: { enrollments: enrollments_data }, status: :ok
  end

  private

  # if final grade column is nil or doesn't exist
  def safe_final_grade(enrollment)
    enrollment.respond_to?(:final_grade) ? (enrollment.final_grade || "") : ""
  end

end
