require 'rest-client'
require 'json'

class CourseController < ApplicationController
	before_action :set_course, only: [:show, :update, :destroy, :all_applicants, :on_time]

	# GET /courses
	def index
		@courses = Course.all
		
		render json: @courses
	end

	# GET /courses/1
	def show
    num_positions_assigned = Offer.where(course_code: @course.course_code, status:"Assigned").length
		applicants_for_course = RestClient.get "http://localhost:3000/courses/#{@course.id}/applicants"
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
		open_courses = []
		courses = Course.all
		courses.map do |course|
			num_positions_assigned = Offer.where(course_code: course.course_code, status:"Assigned").length
			if num_positions_assigned < course.projected_course_enrollment/30
				open_courses.append(course)
			end
		end
		render json: open_courses
	end

  def append_status(applicants_json, course_code)
    applicants_json.map do |a|
      offer = Offer.find_by(utorid: a["utorid"], course_code: course_code)
      if offer.nil?
        a["status"] = "Unassigned"
        a
      else
        a["status"] = offer.status
        a
     end
    end
  end

  def append_remaining_hours(applicants_json)
    applicants_json.map do |a|
      offers = Offer.where(utorid: a["utorid"], status: "Assigned")
      applicant_courses = offers.map { |o| Course
                                       .find_by(course_code: o.course_code)
                                       .required_hours }
      total_assigned_hours = applicant_courses.reduce(:+) || 0
      a["remaining_teaching_hours"] -= total_assigned_hours
      a
    end
  end

	# GET /courses/id/applicants
	def all_applicants
	 	@test = RestClient.get "http://localhost:3000/courses/#{@course.id}/applicants"

		# TESTING 
   # @test = RestClient.get "http://localhost:3000/courses/1/applicants"

    applicants_json = JSON.parse(@test.body)
    # appends applicant status
    applicants_json = append_status(applicants_json, @course.course_code)
    applicants_json = append_remaining_hours(applicants_json)

    # FILTER BY QUERY PARAMS
    # TODO: EXTRACT INTO FUNCTION -> THEN INTO ITS OWN CLASS
    query_params = params[:query]
    if query_params
      query_service = ApplicantQueryService.new(applicants_json, query_params)
      applicants_json = query_service.query

      if query_params[:on_time]
      	applicants_json = applicants_json.select { |a|
      		p "IN HERE NIGGA"
      		p a["submitted_at"]
      		p @course.deadline
      		DateTime.parse(a["submitted_at"]) <= @course.deadline
      	}
      end

      if query_params[:sort_by]
        sort_service = ApplicantSortingService.new(applicants_json, query_params[:sort_by])
        applicants_json = sort_service.order
      end
    end
    p "*"*20
    p applicants_json
		render json: applicants_json
	end

  #/courses/1/on_time
  def on_time
     @all_applications = RestClient.get "http://localhost:3000/courses/1/applications" 
     applications_json = JSON.parse(@all_applications.body) 
     applications_json = applications_json.select { |a| a["submitted_at"] <= @course.deadline  }
     render json: applications_json
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
