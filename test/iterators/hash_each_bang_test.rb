require 'test_helper'

class HashEachBangTest < Minitest::Test
  def setup
    chr_ord = 'a'.ord
    @hash = {}
    10.times do
      @hash[chr_ord.chr] = chr_ord
      chr_ord += 1
    end
  end

  def test_that_it_yield_block
    keys, vals = [], []

    @hash.each! do |k, v|
      keys << k
      vals << v
    end

    ord_range = (('a'.ord)...('a'.ord)+10).to_a
    assert keys == ord_range.map(&:chr)
    assert vals == ord_range
  end

  def test_that_it_remove_elements_from_array_on_the_fly
    @hash.each! {}
    assert @hash.count == 0
  end

  def test_that_it_returns_nil
    return_val = @hash.each! { |el| 1 }
    assert return_val.nil?
  end

  def test_that_it_iterates_and_yields_block_the_same_as_each
    hash_1 = @hash.dup
    hash_2 = @hash.dup

    keys_1, keys_2, vals_1, vals_2 = [], [], [], []

    hash_1.each do |k, v|
      keys_1 << k
      vals_1 << v
    end

    hash_2.each! do |k, v|
      keys_2 << k
      vals_2 << v
    end

    assert keys_1 == keys_2
    assert vals_1 == vals_2
  end

  def test_that_it_does_not_override_each
    hash_size = @hash.size

    @hash.each { |el| nil }

    assert @hash.size == hash_size
  end

  def test_that_it_raises_error_if_not_block_given
    assert_raises(LocalJumpError) { @hash.each! }
  end

  def test_that_it_can_use_class_method
    hash_1 = @hash.dup
    hash_2 = @hash.dup

    keys_1, keys_2, vals_1, vals_2 = [], [], [], []

    hash_1.each do |k, v|
      keys_1 << k
      vals_1 << v
    end

    HyperIterator.each!(hash_2) do |k, v|
      keys_2 << k
      vals_2 << v
    end

    assert keys_1 == keys_2
    assert vals_1 == vals_2
    assert hash_2.empty?
  end
end
