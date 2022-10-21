#!/bin/bash

rm -f tmp/pids/server.pid
bundle exec rails db:setup
bundle exec rails server -p 8080 -b '0.0.0.0' -e production
