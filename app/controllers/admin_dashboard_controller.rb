class AdminDashboardController < ApplicationController
  
  def index
    today = Date.today

    @current_trimester = Trimester
      .where("start_date <= ?", today)
      .where("end_date >= ?", today)
      .first

    @upcoming_trimester = Trimester
      .where("start_date > ?", today)
      .where("start_date < ?", today + 6.months)
      .order(:start_date)
      .first
  end
end
