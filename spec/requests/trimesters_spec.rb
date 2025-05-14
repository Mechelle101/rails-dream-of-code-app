require 'rails_helper'

RSpec.describe "Trimesters", type: :request do
  describe "GET /trimesters" do
    context 'trimesters exist' do
      before do
        (1..2).each do |i|
          Trimester.create!(
            term: "Term #{i}",
            year: '2025',
            start_date: '2025-01-01',
            end_date: '2025-01-01',
            application_deadline: '2025-01-01',
          )
        end
      end

      it 'returns a page containing names of all trimesters' do
        get '/trimesters'
        expect(response.body).to include('Term 1 2025')
        expect(response.body).to include('Term 2 2025')
      end
    end
  end
end

context 'no trimesters exist' do
  it 'returns a page with the title "Trimesters" and no list items' do
    get '/trimesters'
    expect(response.body).to include('Trimesters')
    expect(response.body).not_to include('<li>')
  end
end

RSpec.describe "Trimester", type: :request do
  let!(:trimester) do
    Trimester.create!(
      term: "Fall",
      year: "2025",
      start_date: "2025-03-31",
      end_date: "2025-06-30",
      application_deadline: "2025-01-01"
    )
  end

  describe "GET /trimesters/:id/edit" do
    it "returns a page containing 'Application deadline'" do
      get edit_trimester_path(trimester)
      expect(response).to have_http_status(:ok)
      expect(response.body).to include("Application deadline")
    end
  end

  describe "PUT /trimesters/:id" do
    it "update the application deadline with a valid date" do
      put trimester_path(trimester), params: {trimester: {application_deadline: "2025-05-15"}}
      expect(response).to redirect_to(trimesters_path)
      follow_redirect!
      expect(trimester.reload.application_deadline.to_s).to eq("2025-05-15")
    end

    it "returns 400 if application deadline is missing" do
      put trimester_path(trimester), params: {trimester: {application_deadline: nil}}
      expect(response).to have_http_status(:bad_request)
    end

    it "returns 400 if application deadline is invalid" do
      put trimester_path(trimester), params: {trimester: {application_deadline: "not-a-date"}}
      expect(response).to have_http_status(:bad_request)
    end

    it "returns 404 if trimester does not exist" do
      put "/trimesters/99999", params: {trimester: {application_deadline: "2025-06-01"}}
      expect(response).to have_http_status(:not_found)
    end
  end
end
