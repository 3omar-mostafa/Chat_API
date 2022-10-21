#!/bin/bash

rm -f tmp/pids/server.pid || true
bundle exec rails db:setup || true
bundle exec rails server -p 8080 -b '0.0.0.0' -e production
