require "rails_helper"

RSpec.describe "Courses", type: :request do
  describe "GET /courses/:id" do
    let(:today) { Date.today }

    # current trimester
    let!(:current_trimester) do
      Trimester.create!(
        term: "Spring",
        year: today.year.to_s,
        start_date: today - 1.day,
        end_date: today + 2.months,
        application_deadline: today - 2.weeks
        )
    end

    let!(:cc_intro) { CodingClass.create!(title: "Intro to Programming") }
    let!(:course) { Course.create!(trimester: current_trimester, coding_class: cc_intro) }

    # Students + Enrollments...
    let!(:student_1) { Student.create!(first_name: "Mechelle", last_name: "Presnell", email: "me@me.com") }
    let!(:student_2) { Student.create!(first_name: "Bri", last_name: "Malcuit", email: "bri@bri.com") }

    let!(:enroll_1) { Enrollment.create!(course: course, student: student_1) }
    let!(:enroll_2) { Enrollment.create!(course: course, student: student_2) }

    it "shows the enrolled students for the current course" do
      get course_path(course)
      expect(response).to have_http_status(:ok)
      expect(response.body).to include(cc_intro.title)
      expect(response.body).to include("Mechelle Presnell")
      expect(response.body).to include("Bri Malcuit")
    end
  end
end
