module HyperIterator
  module HashEachBang
    def each!
      each do |pair|
        yield pair
        self[pair[0]] = nil
      end
      nil
    end
  end
end