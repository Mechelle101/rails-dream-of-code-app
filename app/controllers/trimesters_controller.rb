class TrimestersController < ApplicationController
  before_action :set_trimester, only: [:show, :edit, :update]

  def index
    @trimesters = Trimester.all
  end

  def show

  end

  def edit
    # renders the form
  end

  # PUT /trimesters/:id
  def update
    deadline_str = params.dig(:trimester, :application_deadline)

    # missing parameter - 400
    return render(plain: "application_deadline is required", status: :bad_request) if deadline_str.blank?

    # invalid date - 400
    begin
      parsed_date = Date.parse(deadline_str.to_s)
    rescue ArgumentError
      return render(plain: "invalid date", status: :bad_request)
    end

  # Update; if something else fails validation, treat as 400
  if @trimester.update(application_deadline: parsed_date)
    # success: redirect back to edit
    redirect_to edit_trimester_path(@trimester), notice: "Application deadline updated."
  else
    render plain: @trimester.errors.full_messages.join(", "), status: :bad_request
  end
end

  private

  def set_trimester
    @trimester = Trimester.find(params[:id])
  rescue ActiveRecord::RecordNotFound
    render plain: "not found", status: :not_found
  end
end
