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

Seeding a new Course:

- > c = Course.new(
    :course_code => "csc108",
    :description => "The CSC108 Description",
    :term => "Fall 2017",
    :students_per_TA => 10,
    :projected_course_enrollment => 1000,
    :instructor_id => "Teacher_2",
    :requirements => "None"
    )
    c.save!

## Starting the server

From the console:

> $> PORT=8080 rails server puma

This will start the Rails app on port 8080.
