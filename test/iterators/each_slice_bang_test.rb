require 'test_helper'

class EachSliceBangTest < Minitest::Test
  def test_that_it_slices_array
    arr = (1..10).to_a
    arr_dup = arr.dup
    arr_size = arr.size
    slice_size = rand(1..5)

    sliced_arrs = []

    arr.each_slice!(slice_size) do |slice|
      sliced_arrs << slice
    end

    if arr_size % slice_size != 0
      assert sliced_arrs.size == (arr_size / slice_size) + 1
    else
      assert sliced_arrs.size == arr_size / slice_size
    end

    assert arr_dup == sliced_arrs.flatten
  end

  def test_that_it_yield_block
    arr = (1..10).to_a
    arr_dup = arr.dup
    new_arr = []

    slice_size = rand(1..5)

    arr.each_slice!(slice_size) do |slice|
      slice.each do |el|
        new_arr << el * 2
      end
    end

    assert new_arr == arr_dup.map { |n| n * 2 }
  end

  def test_that_it_remove_elements_from_array_on_the_fly
    arr = (1..10).to_a

    slice_size = rand(1..5)
    arr.each_slice!(slice_size) { |slice| nil }

    assert arr.size == 0
  end

  def test_that_it_returns_nil
    arr = (1..10).to_a

    slice_size = rand(1..5)
    return_val = arr.each_slice!(slice_size) { |slice| nil }

    assert return_val.nil?
  end
end
