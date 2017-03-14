FROM ubuntu
RUN \
  apt-get update && \
  apt-get install -y ruby
RUN ruby -v
RUN gem install require_all
CMD ruby ./benchmark/bm_all.rb

# docker run -m=50m -v `pwd`:`pwd` -w `pwd` hyper_iterator