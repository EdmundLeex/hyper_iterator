require 'require_all'
require_relative "./hyper_iterator/version"
require_all 'lib/iterators/**/*.rb'

module HyperIterator
  AVAILABLE_METHODS = [
    :each_slice!,
    :each!
  ].freeze
end

class Array
  include HyperIterator
end
