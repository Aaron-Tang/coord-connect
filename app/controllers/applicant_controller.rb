require 'json'
require 'rest-client'

class ApplicantController < ApplicationController
  def index
    @request = RestClient.get "http://localhost:3000/users"
    applicants_json = JSON.parse(@request.body)
    
    applicants_json = append_remaining_hours(applicants_json)

    query_params = params[:query]
    if query_params
      query_service = ApplicantQueryService.new(applicants_json, query_params)
      applicants_json = query_service.query
    end

    render json: applicants_json
  end


private
 # TODO: this won't work. need to update for this case
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


end
