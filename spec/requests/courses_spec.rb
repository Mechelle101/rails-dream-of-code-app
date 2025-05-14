require 'rails_helper'

RSpec.describe 'Courses', type: :request do
  describe 'GET /courses/:id' do

    before do
      # creating a trimester
      @trimester = Trimester.create!(
        year: '2025',
        term: 'Summer',
        start_date: Date.today + 1.month,
        end_date: Date.today + 5.months,
        application_deadline: Date.today + 2.months
      )

      # creating a coding class
      @coding_class = CodingClass.create!(title: "Test Course")

      # creating a course and associating it with the coding class
      @course = Course.create!(coding_class: @coding_class, trimester_id: 1)

      # creating students
      @student = Student.create!(first_name: "Mechelle", last_name: "Presnell", email: "me@me.com")

      # enrolling the students in the course
      Enrollment.create!(course: @course, student: @student)
    end

    it 'display the course name' do
      # requesting the course page
      get course_path(@course)

      # expecting the page to include the course title (coding class title)
      expect(response.body).to include(@course.coding_class.title)
    end

    it 'display the student name' do
      # requesting the course page
      get course_path(@course)

      # expecting the page to include the first name of the student
      expect(response.body).to include(@student.first_name)
    end
  end
end
