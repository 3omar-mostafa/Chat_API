FROM ruby:2.7.0
RUN apt-get update && apt-get -y install cron
WORKDIR /app
COPY . ./
# Install gems
RUN bundle install
# Add schedule data to crontab
RUN bundle exec whenever --update-crontab