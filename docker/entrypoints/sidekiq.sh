#!/bin/bash

rm -f tmp/pids/server.pid || true
bundle exec rails db:setup || true
bundle exec sidekiq --queue chat_queue
