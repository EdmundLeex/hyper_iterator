require 'test_helper'

class HighPerformanceIteratorTest < Minitest::Test
  def test_that_it_has_a_version_number
    refute_nil ::HighPerformanceIterator::VERSION
  end

  def test_that_it_makes_iterators_available_in_array_class
    assert HighPerformanceIterator::AVAILABLE_METHODS.all? do |mth|
      Array.respond_to(mth)
    end
  end
end
