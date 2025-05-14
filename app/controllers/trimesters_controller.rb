class TrimestersController < ApplicationController

  def index
    @trimesters = Trimester.all
  end

  def show
    @trimester = Trimester.find(params[:id])
  end

  def edit
    @trimester = Trimester.find(params[:id])
  end

  def update
    @trimester = Trimester.find(params[:id])

    if params[:trimester][:application_deadline].blank?
      render plain: "Missing Application Deadline", status: :bad_request
      return
    end

    begin
      parsed_date = Date.parse(params[:trimester][:application_deadline])
    rescue ArgumentError
      render plain: "Invalid date format", status: :bad_request
      return
    end

    if @trimester.update(application_deadline: parsed_date)
      redirect_to trimesters_path, notice: "Application deadline was successfully updated"
    else
      render :edit, status: :unprocessable_entity
    end

  rescue ActiveRecord::RecordNotFound
    render plain: "Trimester not Found", status: :not_found
  end

  private

  def trimester_params
    params.require(:trimester).permit(:application_deadline)
  end
end
