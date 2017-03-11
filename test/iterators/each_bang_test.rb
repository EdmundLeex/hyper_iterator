require 'test_helper'

class EachSliceBangTest < Minitest::Test
  def test_that_it_yield_block
    arr = (1..10).to_a
    arr_dup = arr.dup
    new_arr = []

    arr.each! do |el|
      new_arr << el * 2
    end

    assert new_arr == arr_dup.map { |n| n * 2 }
  end

  def test_that_it_remove_elements_from_array_on_the_fly
    arr = (1..10).to_a
    arr.each! { |el| nil }

    assert arr.size == 0
  end

  def test_that_it_returns_nil
    arr = (1..10).to_a
    return_val = arr.each! { |el| nil }

    assert return_val.nil?
  end

  def test_that_it_iterates_and_yields_block_the_same_as_each
    arr_1 = (1..10).to_a
    arr_2 = (1..10).to_a
    new_arr_1 = []
    new_arr_2 = []

    arr_1.each do |el|
      new_arr_1 << el * el
    end

    arr_2.each! do |el|
      new_arr_2 << el * el
    end

    assert new_arr_1 == new_arr_2
  end

  def test_that_it_does_not_override_each_slice
    arr = (1..10).to_a
    arr_size = arr.size

    arr.each { |el| nil }

    assert arr.size == arr_size
  end
end
