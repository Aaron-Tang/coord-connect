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

  def for_course
    @course = Course.find(params[:course_id])
    @assignments = Offer.where(course_code: @course.course_code, status: "Assigned")
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
