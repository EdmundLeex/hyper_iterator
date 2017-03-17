require_relative "./hyper_iterator/version"
Dir['./lib/iterators/*.rb'].each { |f| require f }

module HyperIterator
  AVAILABLE_METHODS = [
    :each_slice!,
    :each!
  ].freeze
end

class Array
  include HyperIterator
end
