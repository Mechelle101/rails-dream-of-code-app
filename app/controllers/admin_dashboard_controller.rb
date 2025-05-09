class AdminDashboardController < ApplicationController

  def index
    # fetch current and upcoming trimester data
    @current_trimester = Trimester.where("start_date <= ?", Date.today)
                                  .where("end_date >= ?", Date.today).first
    @upcoming_trimester = Trimester.where("start_date > ?", Date.today)
                                  .where("start_date <= ?", Date.today + 6.months).first
                                   
  end

end
