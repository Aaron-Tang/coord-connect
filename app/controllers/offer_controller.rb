class OfferController < ApplicationController
before_action :set_application, only: [:show, :update, :destroy]

	# GET /applications
	def index
		@applications = Offer.all
		
		render json: @applications
	end

	def create
    # TODO: SET THE APPLICATION ID BY QUERYING THE APPLICANT API
		@applied_applicant = Offer.new(application_params.merge({status: "Assigned"}))

		if @applied_applicant.save
			render json: @applied_applicant, status: :created, location: @user
		else
			render json: @applied_applicant.errors, status: :unprocessable_entity
		end
	end

	# GET /applications/1
	def show
		render json: @application
	end

	# PATCH/PUT /applications/1
	def update
		if @application.update(application_params)
			render json: @application
		else
			render json: @application.errors, status: :unprocessable_entity
		end
	end

	# DELETE /applications/1
	def destroy
		@application.destroy
	end

  #/assignments/for_course/:course_id
  def for_course
    @course = Course.find(params[:course_id])
    @status = params[:status]
    @assignments = Offer.where(course_code: @course.course_code, status: @status)
    render json: @assignments
  end
  
  def bulk_create
    applications = params[:assignments]

    saved_apps = []
    applications.map do |application|
      course_code = Course.find(application[:course_id]).course_code
      unless Offer.exists?(course_code: course_code, utorid: application[:utorid])
        course_code = Course.find(application[:course_id]).course_code
        @assignment = Offer.new(
          course_code: course_code,
          utorid: application[:utorid],
          status: "Assigned"
        )
        if not @assignment.save
          render json: @assignment.errors, status: :unprocessable_entity
        else
          saved_apps.push(@assignment)
        end
      end
    end

    render json: saved_apps
  end

  def bulk_update_assignment
    applications = params[:assignments]
    saved_apps = []
    applications.map do |application|
      course_code = Course.find(application[:course_id]).course_code
      assignment = Offer.find_by(course_code: course_code,
                                  utorid: application[:utorid])
      if assignment.nil?
        @new_assignment = Offer.new(
          course_code: course_code,
          utorid: application[:utorid],
          status: application[:status]
        )
        if not @new_assignment.save
          render json: @new_assignment.errors, status: :unprocessable_entity
        else
          saved_apps.push(@new_assignment)
        end
      else
        assignment.update_attributes(status: application[:status])
        saved_apps.push(assignment)
      end
    end

    render json: saved_apps
  end

  def update_assignment
    assignment_params = params[:assignment]
    assignment = Offer.find_by(course_code: assignment_params[:course_code],
                            utorid: assignment_params[:utorid])

    if assignment.update_attributes(status: assignment_params[:status])
 			render json: assignment
		else
			render json: assignment.errors, status: :unprocessable_entity
   end
  end

  #offers/:utorid/:course_id
  def get_offer_for_application
    course_code = Course.find(params[:course_id]).course_code
    assignment = Offer.where(utorid: params[:utorid], course_code: course_code)
    render json: assignment
  end

	private

	# Use callbacks to share common setup or constraints between actions
	def set_application
		@application = Offer.find(params[:id])
	end

	def application_params
		params.require(:applications).permit(
			:application_id,
      :utorid,
      :course_code,
			:status)
	end
end
