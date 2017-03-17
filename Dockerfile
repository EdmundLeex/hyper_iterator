# FROM ubuntu
# RUN \
#   apt-get update && \
#   apt-get install -y cmake && \
#   apt-get install -y ruby2.1.2 && \
#   apt-get install -y ruby-dev
# FROM ruby:2.1.10
# FROM ruby:2.3.0
FROM ruby:2.4.0
RUN ruby -v
RUN gem install require_all
RUN gem install memory_profiler
# CMD \
#   ruby ./benchmark/each.rb

# docker run -m=50m -v `pwd`:`pwd` -w `pwd` hyper_iterator