require "rails_helper"

RSpec.describe "Dashboard", type: :request do
  describe "GET /dashboard" do
    # Helper for readability
    let(:today) { Date.today }

    # Current trimester: start <= today <= end
    let!(:current_trimester) do
      Trimester.create!(
        term: "Spring",
        year: today.year.to_s,
        start_date: today - 1.day,
        end_date: today + 2.months,
        application_deadline: today - 2.weeks
        )
    end

    # past trimester: ends before today 
    let!(:past_trimester) do
      Trimester.create!(
        term: "Winter",
        year: (today.year - 1).to_s,
        start_date: today - 6.months,
        end_date: today - 3.months,
        application_deadline: today - 7.months
      )
    end

    # upcoming trimester: starts after today 
    let!(:upcoming_trimester) do
      Trimester.create!(
        term: "Summer",
        year: today.year.to_s,
        start_date: today + 1.months,
        end_date: today + 4.months,
        application_deadline: today + 2.weeks
      )
    end

    # Course titles live on coding classes
    let!(:cc_intro) { CodingClass.create!(title: "Intro to Programming") }
    let!(:cc_rails) { CodingClass.create!(title: "Ruby on Rails") }
    let!(:cc_python) { CodingClass.create!(title: "Python") }

    let!(:current_course_1) { Course.create!(trimester: current_trimester, coding_class: cc_intro) }
    let!(:current_course_2) { Course.create!(trimester: current_trimester, coding_class: cc_rails) }
    let!(:upcoming_course) { Course.create!(trimester: upcoming_trimester, coding_class: cc_python) }

    it "returns a 200 ok status" do
      get "/dashboard"
      expect(response).to have_http_status(:ok)
    end

    it "Shows the current trimester header and course title" do
      get "/dashboard"
      expect(response.body).to include("Spring - #{today.year}")
      expect(response.body).to include("Intro to Programming")
      expect(response.body).to include("Ruby on Rails")
      # Past should not appear
      expect(response.body).not_to include("Winter - #{today.year - 1}")
    end

    it "displays the upcoming trimester header and it's course title" do
      get "/dashboard"
      expect(response.body).to include("Summer - #{today.year}")
      expect(response.body).to include("Python")
    end

    it "displays the upcoming trimester" do
      today = Date.today

      # a trimester that begins within 6 months should be considered "upcoming"
      fall = Trimester.create!(
        term: "Fall",
        year: today.year.to_s,
        start_date: today + 2.weeks, 
        end_date: today + 3.months,
        application_deadline: today + 1.week
      )

      get "/dashboard"
      expect(response.body).to include("#{fall.term} - #{fall.year}")
    end

  end
end
