require 'test_helper'

class CoursesControllerTest < ActionDispatch::IntegrationTest
	setup do
		@course = courses(:one)
	end

	test "should get index" do
		get courses_url, as : :json
		assert_response :success
	end

	test "should create course" do
		assert_difference('Course.count') do
			post courses_url, params: {course: {
				course_code: "CSC302",
				description: "Not Intro to Engineering",
				term: "F",
				projected_course_enrollment: "250",
				students_per_TA: 25,
				instructor_id: "3",
				requirements: "CSC301"
				}}, as: :json
			end

		assert_response 201
	end

	test "should show course" do 
		get course_url(@course), as: :json
		assert_response :success
	end

	test "should update course" do
		patch courses_url(@course), params:{course: {
			course_code: "CSC302",
			description: "Not Intro to Engineering",
			term: "F",
			projected_course_enrollment: "250",
			students_per_TA: 25,
			instructor_id: "3",
			requirements: "CSC301"
			}}, as: :json
		assert_response 200
	end


	test "should destroy course" do
		assert_difference('Course.count', -1) do
			delete_course_url(@course), as: :json
		end

		assert_response 204
	end
end

