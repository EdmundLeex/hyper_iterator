module HyperIterator
  def each_slice!(slice_size)
    raise ArgumentError, "invalid slice size" if slice_size.is_a?(Integer) || slice_size <= 0
    
    i = 0

    while count > 0
      current_slice = []
      while i < slice_size && count > 0
        current_slice << shift
        i += 1
      end
      yield current_slice
      i = 0
    end
    nil
  end
end