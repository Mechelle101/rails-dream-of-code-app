class AdminDashboardController < ApplicationController
  
  def index
    today = Time.zone.today

    @current_trimester = Trimester
      .includes(courses: :coding_class)
      .where("start_date <= ?", today)
      .where("end_date >= ?", today)
      .first

    @upcoming_trimester = Trimester
      .includes(courses: :coding_class)
      .where("start_date > ?", today)
      .where("start_date < ?", today + 6.months)
      .order(:start_date)
      .first
  end
end
