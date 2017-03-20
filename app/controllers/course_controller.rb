require 'rest-client'
require 'json'

class CourseController < ApplicationController
	before_action :set_course, only: [:show, :update, :destroy, :all_applicants]

	# GET /courses
	def index
		@courses = Course.all
		
		render json: @courses
	end

	# GET /courses/1
	def show
    num_positions_assigned = AppliedApplicant.where(course_code: @course.course_code).length
		applicants_for_course = RestClient.get "http://localhost:3000/course/#{@course.id}/applicants"
    num_applicants_applied = JSON.parse(applicants_for_course).length
		render json: @course.as_json.merge({number_ta_applied: num_applicants_applied, number_positions_assigned: num_positions_assigned})
	end

	# POST /courses
	def create
		@course = Course.new(course_params)

		if @course.save
			render json: @course, status: :created, location: @user
		else
			render json: @course.errors, status: :unprocessable_entity
		end
	end

	# PATCH/PUT /courses/1
	def update
		if @course.update(course_params)
			render json: @course
		else
			render json: @course.errors, status: :unprocessable_entity
		end
	end

	# DELETE /courses/1
	def destroy
		@course.destroy
	end

	# GET /courses/openings
	def openings

	end

	# GET /courses/id/applicants
	def all_applicants
		p(@course.id)
		@test = RestClient.get 'http://localhost:3000/course/1/applicants', {params: {id: @course.id}}
		render json: @test.body
		#p(@test)
	end
	
	private

	# Use callbacks to share common setup or constraints between actions
	def set_course
		@course = Course.find(params[:id])
	end

	def course_params
		params.require(:courses).permit(
			:course_code,
			:description,
			:term,
			:projected_course_enrollment,
			:studentes_per_TA,
			:instructor_id,
			:requirements)
	end
end
