require_relative "../rails_helper"
require_relative "../spec_helper"

RSpec.describe CourseController, type: :controller do

	describe "GET index" do
    it "returns all courses" do
      course = Course.create!(
      	course_code: "CSC301", 
      	description: "Intro to software enginnering", 
      	term: "F",
      	projected_course_enrollment: "250",
      	students_per_TA: 20,
      	instructor_id: "2",
      	requirements: "CSC300")
      get :index
      expect(response.body).to include("CSC301")
    end
  end

  # describe "get course/1/applicants" do
  #   it "returns all applicants for course" do
  #     course = Course.create!(
  #       course_code: "csc301", 
  #       description: "intro to software enginnering", 
  #       term: "f",
  #       projected_course_enrollment: "250",
  #       students_per_TA: 20,
  #       instructor_id: "2",
  #       requirements: "csc300")
  #     get :all_applicants, params: { 
  #       id: course.id
  #       }
  #   end
  # end
  
  # xit "filters all applicants for course" do
  #   course = Course.create!(
  #     course_code: "csc301", 
  #     description: "intro to software enginnering", 
  #     term: "f",
  #     projected_course_enrollment: "250",
  #     students_per_TA: 20,
  #     instructor_id: "2",
  #     requirements: "csc300",)
  #   get :all_applicants, params: { 
  #     id: course.id, 
  #     query: {
  #       department: "ECE",
  #       previously_decline: true 
  #     } 
  #   }
  # end

  describe "checks if course has been applied to on time" do
    xit "returns all applicants for course" do
      d1 = DateTime.new(2017, 3, 21)
      d2 = DateTime.new(2020, 3, 21)
      course = Course.create!(
        course_code: "csc301", 
        description: "intro to software enginnering", 
        term: "f",
        projected_course_enrollment: "250",
        students_per_TA: 20,
        instructor_id: "2",
        requirements: "csc300",
        deadline: d1)
      offer = Offer.create(
        created_at: d2
        )
      get :on_time, params: {
        id: course.id, 
        }
    end
  end
  
  describe "checks if assigned offers for course is less than required" do
    it "returns all course with openings" do
      course1 = Course.create!(
        course_code: "CSC301", 
        description: "Intro to software enginnering", 
        term: "F",
        projected_course_enrollment: "250",
        students_per_TA: 20,
        instructor_id: "2",
        required_TAs: 1)
      course2 = Course.create!(
        course_code: "CSC108", 
        description: "Intro to programming", 
        term: "F",
        projected_course_enrollment: "250",
        students_per_TA: 20,
        instructor_id: "2",
        required_TAs: 2)
      offer1 = Offer.create!(
        course_code: "CSC301",
        utorid: "someid1",
        status: "Assigned"
      )
      offer2 = Offer.create!(
        course_code: "CSC108",
        utorid: "someid2",
        status: "Assigned"
      )
      get :openings
      expect(response.body).to include("CSC108")
      expect(response.body).to_not include("CSC301")
    end
  end
end
