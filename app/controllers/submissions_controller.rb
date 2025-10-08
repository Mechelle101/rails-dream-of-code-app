class SubmissionsController < ApplicationController
  before_action :set_course, only: [:new, :create, :edit, :update]

  # student can create submissions
  before_action :require_login, only: [:new, :create, :edit, :update]
  before_action :require_student, only: [:new, :create]

  # mentor can edit/update submissions
  before_action :require_mentor, only: [:edit, :update]

  # GET /courses/:course_id/submissions/new
  def new
    @course = Course.find(params[:course_id])
    @submission = Submission.new
    # only students enrolled in this course
    @enrollments = @course.enrollments.includes(:student).references(:student)
    @students = @enrollments.map(&:student)
    
    @lessons = Lesson.where(course_id: @course.id)
  end

  # POST /courses/:course_id/submissions
  def create
    @course = Course.find(params[:course_id])
    @submission = Submission.new(submission_params)

    # rebuild the dropdown menu if needing to rerender the form
    @enrollments = @course.enrollments.includes(:student).references(:student)
    @students = @enrollments.map(&:student)
    @lessons = Lesson.where(course_id: @course.id)

    if @submission.save
      redirect_to course_path(@course), notice: 'Submission was successfully created.'
    else
      render :new, status: :unprocessable_entity
    end
  end

  # GET /submissions/1/edit
  def edit
  end

  # PATCH/PUT /submissions/1 or /submissions/1.json
  def update
  end

  private

    def set_course
      @course = Course.find(params[:course_id])
    end

    # Only allow a list of trusted parameters through.
    def submission_params
      params.require(:submission).permit(:lesson_id, :enrollment_id, :mentor_id, :review_result, :reviewed_at)
    end
end
