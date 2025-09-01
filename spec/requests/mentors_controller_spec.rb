require 'rails_helper'

# this gives you "get, post" and response obj
RSpec.describe "Mentors", type: :request do
  describe "GET /mentors" do
    context 'when mentors exist' do

      before do
        Mentor.create!(first_name: "Bri", last_name: "Mal", email: "b@b.com")
        Mentor.create!(first_name: "John", last_name: "doe", email: "j@d.com")
      end

      it 'returns a page that lists mentors' do
        get '/mentors'
        expect(response).to have_http_status(:ok)

        expect(response.body).to include("<h1>Mentors</h1>")
        expect(response.body).to include("First name:")
        expect(response.body).to include("Last name:")
        expect(response.body).to include("Email:")

        expect(response.body).to include("Bri")
        expect(response.body).to include("Mal")
        expect(response.body).to include("b@b.com")

        expect(response.body).to include("Show this mentor")
      end
    end

    context "when no mentor exist" do
      it "shows the page title and no list items" do
        get "/mentors"
        expect(response).to have_http_status(:ok)
        expect(response.body).to include("<h1>Mentors</h1>")
        expect(response.body).not_to include("<li>")
      end
    end
  end

    describe "GET /mentors/:id" do
      context "when a mentor exists" do
        let!(:mentor) { Mentor.create!(first_name: "John", last_name: "Doe", email: "j@d.com") }

        it "returns a page containing that mentor's details" do
          get "/mentors/#{mentor.id}"
          expect(response).to have_http_status(:ok)

          expect(response.body).to include("First name:")
          expect(response.body).to include("Last name:")
          expect(response.body).to include("Email:")

          
          expect(response.body).to include("John")
          expect(response.body).to include("Doe")
          expect(response.body).to include("j@d.com")

          expect(response.body).to include("Edit this mentor")
          expect(response.body).to include("Back to mentors")
        end
      end

      context "when a mentor does not exist" do
        it "raises ActiveRecord::RecordNotFound" do
          expect{get "/mentors/999999"}.to raise_error(ActiveRecord::RecordNotFound)
      end
    end
  end
end
