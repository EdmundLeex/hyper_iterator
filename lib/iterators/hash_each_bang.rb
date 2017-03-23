module HyperIterator
  module HashEachBang
    def each!
      while count > 0
        yield first
        delete first[0]
      end
      nil
    end
  end
end