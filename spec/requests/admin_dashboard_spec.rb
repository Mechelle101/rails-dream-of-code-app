require 'rails_helper'

RSpec.describe 'Dashboard', type: :request do
  describe 'GET /dashboard' do

    before do
      @current_trimester = Trimester.create!(
        term: 'Current term',
        year: Date.today.year.to_s,
        start_date: Date.today - 1.day,
        end_date: Date.today + 2.months,
        application_deadline: Date.today - 16.days
      )

      # defining the upcoming trimester
      @upcoming_trimester = Trimester.create!(
        term: 'Upcoming term',
        year: (Date.today.year + 1).to_s,
        start_date: Date.today + 3.months,
        end_date: Date.today + 6.months,
        application_deadline: Date.today + 1.month
      )

      # define past trimester here 
      @past_trimester = Trimester.create!(
      term: 'Past term',
      year: (Date.today.year - 1).to_s,
      start_date: Date.today - 2.months,
      end_date: Date.today - 1.day,
      application_deadline: Date.today - 30.days
      )
    end

    it 'returns a 200 OK status' do
      # send a GET request to the dashboard route
      get "/dashboard" 
      
      # check that the response status is 200 (ok)
      expect(response).to have_http_status(:ok)
    end

    it 'displays the current trimester' do
      get "/dashboard"
      expect(response.body).to include("Current term - #{Date.today.year}")
    end

    it 'displays links to the courses in the current trimester' do
    end

    it 'displays the upcoming trimester' do
      get "/dashboard"
      expect(response.body).to include("#{@upcoming_trimester.term} - #{@upcoming_trimester.year}")
    end

    it 'displays links to the courses in the upcoming trimester' do
    end

  end
end

