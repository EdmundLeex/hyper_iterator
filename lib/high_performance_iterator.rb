require 'require_all'
require_relative "./high_performance_iterator/version"
require_all 'lib/iterators/**/*.rb'

module HighPerformanceIterator
  AVAILABLE_METHODS = [
    :each_slice!
  ].freeze
end

class Array
  include HighPerformanceIterator
end
