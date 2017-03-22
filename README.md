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
``` ruby 
1. > $> rake db:reset 

Sometimes, db:reset doesn't seed the db after running. Check in rails console with Course.all.
If there aren't any entries, run: rake db:seed in normal console to seed the db.
```
## Starting the server

From the console:

> $> PORT=8080 rails server puma

This will start the Rails app on port 8080.
