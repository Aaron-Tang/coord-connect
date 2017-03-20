# README

## Prerequisites

1. Postgres
2. Ruby On Rails

## Installation Steps

From the Console:

1. > $> bundle install
2. > $> rake db:create
3. > $> rake db:migrate

## Seeding data

From the console:

1. > $> rails console

*Seeding courses*
```ruby
c = Course.new(
  :course_code => "csc108",
  :description => "The CSC108 Description",
  :term => "Fall 2017",
  :students_per_TA => 10,
  :projected_course_enrollment => 1000,
  :instructor_id => "Teacher_2",
  :requirements => "None")
c.save!
```
*Seeding applied_applicants - run in ta-connect*
```ruby
c = Course.new(
  :course_code => "csc108", 
  :description => "Test")
c.save!

d = TaApplication.new(
  :details => "details", 
  :user_id => 1, 
  :course_id => 1, 
  :previous_ta_experience => false, 
  :preferences => 0)
d.save!

e = User.new(
  :utorid => 0,
  :password_digest => "?",
  :student_number => 99999,
  :family_name => "Grey",
  :given_name => "Jean",
  :program => "CS",
  :year => 2017,
  :previous_ta_experience => false,
  :work_status => true,
  :work_status_explain => "Work Status Explain",
  :department => "Department",
  :department_explanation => "Department Explanation",
  :phone_number => "416-999-999")
e.save!
```

## Starting the server

From the console:

> $> PORT=8080 rails server puma

This will start the Rails app on port 8080.
