class Api::V1::StudentsController < ApplicationController
  # normally authenticated via an API key 
  skip_before_action :verify_authenticity_token

rescue_from(ActionController::ParameterMissing) do
  render json: { errors: ["Missing or malformed parameters"] }, status: :bad_request
end

  def create
    student = Student.new(student_params)

    if student.save
      student_hash = {
        id: student.id,
        first_name: student.first_name,
        last_name: student.last_name,
        email: student.email
      }
      render json: { student: student_hash }, status: :created
    else
      render json: { errors: student.errors.full_messages }, status: :unprocessable_entity
    end
  end

  private

  # protecting the app and ignoring extra data
  def student_params
    params.require(:student).permit(:first_name, :last_name, :email)
  end

end
