module HyperIterator
  def each_slice!(slice_size, &blk)
    while count > 0
      the_slice = slice!(0...slice_size)
      blk.call(the_slice)
    end
    nil
  end
end