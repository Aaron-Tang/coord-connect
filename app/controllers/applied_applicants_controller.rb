class AppliedApplicantsController < ApplicationController
before_action :set_application, only: [:show, :update, :destroy]

	# GET /applications
	def index
		@applications = AppliedApplicant.all
		
		render json: @applications
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

	private

	# Use callbacks to share common setup or constraints between actions
	def set_application
		@application = AppliedApplicant.find(params[:id])
	end

	def application_params
		params.require(:applications).permit(
			:application_id,
			:status)
	end
end
