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

  def test_that_it_slices_and_yields_block_the_same_as_each_slice
    arr_1 = (1..10).to_a
    arr_2 = (1..10).to_a
    new_arr_1 = []
    new_arr_2 = []
    sliced_arr_1 = []
    sliced_arr_2 = []
    slice_size = rand(1..5)

    arr_1.each_slice(slice_size) do |slice|
      sliced_arr_1 << slice
      slice.each { |el| new_arr_1 << el * el }
    end

    arr_2.each_slice!(slice_size) do |slice|
      sliced_arr_2 << slice
      slice.each { |el| new_arr_2 << el * el }
    end

    assert new_arr_1 == new_arr_2
    assert sliced_arr_1 == sliced_arr_2
  end

  def test_that_it_does_not_override_each_slice
    arr = (1..10).to_a
    arr_size = arr.size

    slice_size = rand(1..5)
    return_val = arr.each_slice(slice_size) { |slice| nil }

    assert arr.size == arr_size
  end
end
