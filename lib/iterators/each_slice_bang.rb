module HyperIterator
  def each_slice!(slice_size, &blk)
    i = 0

    while count > 0
      current_slice = []
      while i < slice_size && count > 0
        current_slice << shift
        i += 1
      end
      blk.call(current_slice)
      i = 0
    end
    nil
  end
end