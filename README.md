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
Make sure you've run rake db:migrate to have all the migrations first before seeding the data.

From the console:

1. > $> rake db:reset db:seed

## Starting the server

From the console:

> $> PORT=8080 rails server puma

This will start the Rails app on port 8080.
