#!/bin/bash

rm -f tmp/pids/server.pid
bundle exec sidekiq --queue chat_queue
