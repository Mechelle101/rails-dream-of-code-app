class SubmissionsController < ApplicationController
  # GET /submissions/new
  def new
    @course = Course.find(params[:course_id])
    @submission = Submission.new
    # TODO: What set of enrollments should be listed in the dropdown?
    @enrollments = @course.enrollments.includes(:student)
    # TODO: What set of lessons should be listed in the dropdown??
    @lessons = @course.lessons # the lessons for the course
  end

  def create
    @course = Course.find(params[:course_id])
    # ensuring the submission is correctly scoped to the course
    @submission = @course.submissions.new(submission_params)

    if @submission.save
      redirect_to course_path(@course), notice: 'Submission was successfully created.'
    else
      # TODO: Set this up just as in the new action
      @enrollments = @course.enrollments.includes(:student)
      # TODO: Set this up just as in the new action
      @lessons = @course.lessons
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
    # Only allow a list of trusted parameters through.
    def submission_params
      params.require(:submission).permit(:lesson_id, :enrollment_id, :mentor_id, :review_result, :reviewed_at)
    end
end
