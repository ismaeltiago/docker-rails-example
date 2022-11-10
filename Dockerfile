FROM ruby:3.1.2-slim-buster
RUN apt-get update -y && apt-get install -y build-essential libpq-dev apt-utils
ENV APP_HOME foo_app
RUN mkdir /$APP_HOME
WORKDIR /$APP_HOME
ADD Gemfile /$APP_HOME/Gemfile
ADD Gemfile.lock /$APP_HOME/Gemfile.lock
RUN bundle install
ADD . /$APP_HOME