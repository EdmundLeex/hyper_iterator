FROM ubuntu
RUN \
  apt-get update && \
  apt-get install -y ruby
RUN ruby -v
RUN gem install require_all
# ADD . ./
CMD ruby ./benchmark/bm_all.rb

# docker run -v /host/directory:/container/directory -other -options image_name command_to_run
