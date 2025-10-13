class Api::V1::CoursesController < ApplicationController
  def index
    # 1. find the current trimester (where today is between start and end)
    current_trimester = Trimester
      .where("start_date <= ? AND end_date >= ?", Date.today, Date.today)
      .first

    # 2. collect it's courses (or an empty array is none)
    current_courses = current_trimester ? current_trimester.courses : []

    # 3. building the json response
    courses_data = current_courses.map do |course|
      {
        id: course.id,
        title: course.coding_classes.title,
        application_deadline: current_trimester.application_deadline,
        start_date: current_trimester.start_date,
        end_date: current_trimester.end_date
      }
    end

    render json: { courses: courses_data }, status: :ok
  end

end