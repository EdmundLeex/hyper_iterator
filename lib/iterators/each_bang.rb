module HyperIterator
  def each!(&blk)
    while count > 0
      blk.call(shift)
    end
    nil
  end
end