class CoursesController < ApplicationController
  # Ensuring @course is loaded
  before_action :set_course, only: %i[ show edit update destroy ]

  # GET /courses or /courses.json
  def index
    @courses = Course.includes(:coding_class, :trimester)
  end

  # find the course by id, if in the current trimester load students
  def show
    # @course = Course.find(params[:id])
    @students = current_course?(@course) ? @course.students : []
  end

  # GET /courses/new
  def new
    @course = Course.new
  end

  # GET /courses/1/edit
  def edit
  end

  # POST /courses or /courses.json
  def create
    @course = Course.new(course_params)

      if @course.save
        # redirects to the new courses show page
        redirect_to @course, notice: "The course was successfully created."
      else
        # rerender the new form with the error
        render :new, status: :unprocessable_entity
      end
    end

  # PATCH/PUT /courses/1 or /courses/1.json
  def update
    if @course.update(course_params)
      redirect_to @course, notice: "Course was successfully updated."
      else
        render :edit, status: :unprocessable_entity
      end
  end

  # DELETE /courses/1 or /courses/1.json
  def destroy
    @course.destroy!
    redirect_to courses_path, status: :see_other, notice: "Course was successfully destroyed."
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_course
      @course = Course.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def course_params
      params.require(:course).permit(:coding_class_id, :trimester_id, :max_enrollment)
    end

    # checks if a course is part of the current trimester
    # returns true if today's date fall between the start and end date
    def current_course?(course)
      t = course.trimester
      return false if t.nil?
      today = Date.today
      t.start_date <= today && today <= t.end_date
    end
end
