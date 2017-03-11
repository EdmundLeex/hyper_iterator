require 'test_helper'

class HyperIteratorTest < Minitest::Test
  def test_that_it_has_a_version_number
    refute_nil ::HyperIterator::VERSION
  end

  def test_that_it_makes_iterators_available_in_array_class
    assert HyperIterator::AVAILABLE_METHODS.all? do |mth|
      Array.respond_to(mth)
    end
  end
end
