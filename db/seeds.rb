# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
d1 = DateTime.new(2017, 3, 21)
d2 = DateTime.new(2017, 4, 20)

Course.create([
	{
		:course_code => "CSC108",
		:description => "Programming in a language such as Python",
		:term => "Winter 2017",
		:students_per_TA => 10,
		:projected_course_enrollment => 1000, 
		:instructor_id => "Teacher_2",
		:requirements => "None",
		:created_at => d1,
    	:required_hours => 15,
    	:deadline => d2
		},	
	{
		:course_code => "CSC148",
		:description => "Abstract data types and dat structures for implementing them",
		:term => "Fall 2017",
		:students_per_TA => 15,
		:projected_course_enrollment => 1200,
		:instructor_id => "Teacher_5",
		:requirements => "CSC108",
		:created_at => d1,
	    :required_hours => 5,
	    :deadline => d2
		},
	{
		:course_code => "CSC165",
		:description => "Introduction to abstraction and rigour",
		:term => "Fall 2017",
		:students_per_TA => 20,
		:projected_course_enrollment => 1500,
		:instructor_id => "Teacher_8",
		:requirements => "None",
		:created_at => d1,
	    :required_hours => 20,
	    :deadline => d2
		},
	{
		:course_code => "CSC236",
		:description => "The application of logic and proof techniques to Computer Science",
		:term => "Winter 2017",
		:students_per_TA => 25,
		:projected_course_enrollment => 2000,
		:instructor_id => "Teacher_18",
		:requirements => "CSC148, CSC165",
		:created_at => d1,
	    :required_hours => 15,
	    :deadline => d2
	}])

