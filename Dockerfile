# Pick a version of your choice
# If you don't see one, please check this page
# https://hub.docker.com/_/ruby/
# and add it here

# FROM ruby:2.1.10
# FROM ruby:2.2.2
# FROM ruby:2.2.6
# FROM ruby:2.3.0
# FROM ruby:2.3.3
FROM ruby:2.4.0
RUN ruby -v
RUN gem install require_all
