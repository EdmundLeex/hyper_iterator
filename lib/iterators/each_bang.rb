module HyperIterator
  module EachBang
    def each!
      while count > 0
        yield shift
      end
      nil
    end
  end
end