require 'rails_helper'

RSpec.describe "Api::V1::Students", type: :request do
  let(:path) { "/api/v1/students" }
  let(:headers) { { "CONTENT_TYPE" => "application/json", "ACCEPT" => "application/json" } }

  describe "POST /api/v1/students" do
    context "with valid params" do
      let(:valid_attributes) do
        {
          student: {
            first_name: Faker::Name.first_name,
            last_name: Faker::Name.last_name,
            email: 'validstudent@example.com'
          }
        }
      end

      it "creates a new student and returns 201 with the student payload" do
        expect {
          post path, params: valid_attributes.to_json, headers: headers
        }.to change(Student, :count).by(1)

        expect(response).to have_http_status(:created)

        body = JSON.parse(response.body)
        expect(body).to have_key("student")
        expect(body["student"]["email"]).to eq("validstudent@example.com")
        expect(body["student"]).to include("id", "first_name", "last_name", "email")

        expect(JSON.parse(response.body)['student']['email']).to eq("validstudent@example.com")
      end
    end

    context "with invalid params (missing required fields)" do
      it "returns 422 with errors when first_name and last_name are missing but email is present" do
        invalid_payload = {
          student: { email: "test@app.com" }
        }

        post path, params: invalid_payload.to_json, headers: headers

        expect(response).to have_http_status(:unprocessable_entity)

        body = JSON.parse(response.body)
        expect(body).to have_key("errors")
        expect(body["errors"]).to include("First name can't be blank")
        expect(body["errors"]).to include("Last name can't be blank")
      end

      it "returns 400 with a ParameterMissing-style error when all fields are missing" do
        empty_payload = { student: {} }

        post path, params: empty_payload.to_json, headers: headers

        expect(response).to have_http_status(:bad_request)

        body = JSON.parse(response.body)
        expect(body).to have_key("errors")
        expect(body["errors"]).to include("Missing or malformed parameters")
      end

        it "returns 422 with validation errors when fields are blank strings" do

          blank_payload = { student: { first_name: "", last_name: "", email: "" } }

          post path, params: blank_payload.to_json, headers: headers

          expect(response).to have_http_status(:unprocessable_entity)

          body = JSON.parse(response.body)
          expect(body["errors"]).to include(
            "First name can't be blank",
            "Last name can't be blank",
            "Email can't be blank"
          )
      end
    end
  end
end
