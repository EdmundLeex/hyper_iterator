FROM ubuntu
RUN \
  apt-get update && \
  apt-get install -y ruby
RUN ruby -v
RUN gem install require_all
CMD \
  ruby ./benchmark/each_bang.rb && \
  ruby ./benchmark/each.rb

# docker run -m=50m -v `pwd`:`pwd` -w `pwd` hyper_iterator