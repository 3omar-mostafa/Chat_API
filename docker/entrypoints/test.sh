#!/bin/bash

rm -f tmp/pids/server.pid
unset DATABASE_URL # if DATABASE_URL is set, it will override the database.yml config and use production database
export RAILS_ENV=test
bundle exec rails db:setup
bundle exec rspec --color --tty
