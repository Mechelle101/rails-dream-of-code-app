class TrimestersController < ApplicationController

  def index
    # fetching trimester data from the db
    @trimesters = Trimester.all

  end

  def show
    @trimester = Trimester.find(params[:id]) #fetching the trimester by id
  end
end