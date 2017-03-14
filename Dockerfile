FROM ubuntu
RUN \
  apt-get update && \
  apt-get install -y cmake && \
  apt-get install -y ruby && \
  apt-get install -y ruby-dev
RUN ruby -v
RUN gem install require_all
RUN gem install memory_profiler
CMD \
  ruby ./benchmark/each_bang.rb && \
  ruby ./benchmark/each.rb

# docker run -m=50m -v `pwd`:`pwd` -w `pwd` hyper_iterator