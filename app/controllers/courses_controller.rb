class CoursesController < ApplicationController
  # Ensuring @course is loaded
  before_action :set_course, only: %i[ show edit update destroy ]

  # GET /courses or /courses.json
  def index
    @courses = Course.all
  end

  # find the course by id, if in the current trimester load students
  def show
    @course = Course.find(params[:id])
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

    respond_to do |format|
      if @course.save
        # redirects to the new courses show page
        format.html { redirect_to @course, notice: "The course was successfully created."}
      else
        # rerender the new form with the error
        format.html { render :new, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /courses/1 or /courses/1.json
  def update
    respond_to do |format|
      if @course.update(course_params)
        format.html { redirect_to @course, notice: "Course was successfully updated." }
        format.json { render :show, status: :ok, location: @course }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @course.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /courses/1 or /courses/1.json
  def destroy
    @course.destroy!

    respond_to do |format|
      format.html { redirect_to courses_path, status: :see_other, notice: "Course was successfully destroyed." }
      format.json { head :no_content }
    end
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
      today = Date.today
      t.start_date <= today && t.end_date >= today
    end
end
