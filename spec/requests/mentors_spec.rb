require 'rails_helper'

RSpec.describe "Mentors", type: :request do
  # GET /mentors (List Route)
  describe "GET /mentors" do
    context 'mentors exist' do
      before do
        #create some mentors in the database
        (1..2).each do |i|
          Mentor.create!(
            first_name: "MentorFirst#{i}",
            last_name: "MentorLast#{i}",
            email: "mentor#{i}@gmail.com",
            max_concurrent_students: 5
          )
        end
      end

      it 'returns a page of names of all mentors' do
        # this simulates the GET request to the mentors index route
        get '/mentors'

        # checking if the response body includes the names of the mentors
        expect(response.body).to include('MentorFirst1')
        expect(response.body).to include('MentorLast1')
        expect(response.body).to include('MentorFirst2')
        expect(response.body).to include('MentorLast2')
      end
    end

    context 'no mentors exist' do
      it 'returns a page with the title "Mentors" and no mentor names' do
        # simulating a GET request when there are no mentors in the database
        get '/mentors'

        # ensuring the response body contains the title but no mentor names or list items
        expect(response.body).to include('Mentors')
        expect(response.body).not_to include('<li>')
      end
    end
  end

  # GET /mentors/:id (Show Route)
  describe "GET /mentors/:id" do
    context 'mentor exists' do
      before do
        @mentor = Mentor.create!(
          first_name: "Mechelle",
          last_name: "Presnell",
          email: "mechelle@gmail.com",
          max_concurrent_students: 5
        )
      end

      it 'returns a page containing the mentor\'s details' do
        get "/mentors/#{@mentor.id}"
        expect(response.body).to include('Mechelle')
        expect(response.body).to include('Presnell')
        expect(response.body).to include('mechelle@gmail.com')
        expect(response.body).to include('5')
      end
    end

    context 'mentor does not exist' do
      it 'returns a 404 error' do
        get "/mentors/999999" #this should not exist?
        expect(response.status).to eq(404)
      end
    end
  end

end