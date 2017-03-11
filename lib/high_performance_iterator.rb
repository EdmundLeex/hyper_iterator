require 'require_all'
require_relative "./high_performance_iterator/version"
require_all 'lib/iterators/**/*.rb'

module HighPerformanceIterator
  # Your code goes here...
end

class Array
  include HighPerformanceIterator
end
