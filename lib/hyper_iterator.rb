require_relative "./hyper_iterator/version"
require_relative "./iterators/each_bang"
require_relative "./iterators/each_slice_bang"

module HyperIterator
  AVAILABLE_METHODS = [
    :each_slice!,
    :each!
  ].freeze
end

Array.include HyperIterator
