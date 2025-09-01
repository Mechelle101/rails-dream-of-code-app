require 'rails_helper'
# this gives you "get, post" and response obj
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
        expect(response).to have_http_status(:ok)
        expect(response.body).to include('Term 1 2025')
        expect(response.body).to include('Term 2 2025')
      end
    end

    context "trimesters do not exist" do
      it "shows the title and no list items" do
        get "/trimesters"
        expect(response).to have_http_status(:ok)
        expect(response.body).to include("<h1>Trimesters</h1>")
        expect(response.body).not_to include("<li>")
      end
    end
  end
end
