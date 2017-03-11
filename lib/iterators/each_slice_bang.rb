module HighPerformanceIterator
  def each_slice!(slice_size, &blk)
    while count > 0
      blk.call(slice!(0...slice_size))
    end
    nil
  end
end