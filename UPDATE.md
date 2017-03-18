### 3/18/17

- Created [hyper_iterator-rails](https://github.com/EdmundLeex/hyper_iterator-rails) as 
the adapter to Rails, since ActiveRecord implements its own `each` method
- Added `HyperIterator.each!(array)` as a backup method. `each` is a widely implemented 
method in many gems (e.g. the one we need to deal with is the pg gem). Because of that 
adding this method that takes an array as argument can be more versatile without monkey 
patching for each individual library.

### 3/16/17

- Tweak the two benchmark file and made it work
- This time around, I am dynamically creating new arrays and counting the number of 
iterations before it blows up. And it's clear that the `each!` can complete more iteration 
before it uses all the memory
- Changed `each_slice!` implementation to avoid using `slice!`. The execution time comp 
looks good (seems even faster than the native `each_slice`). And the memory usage comp 
looks very good too!

### 3/14/17

- Testing benchmark in containerized environment to simulate limited allocated memory.
- `each!` seems to be working fine. I can see gradual memory release in docker stat even
not by a large margin.
- Next thing to test would be creating more objects within the iteration to use up more 
memory. Given that with 4MB allocation, the current [./benchmark/each.rb](benchmark/each.rb) 
and [./benchmark/each_bang.rb](benchmark/each_bang.rb) is running at the edge of using up 
all memory, creating more objects supposedly would kill the process using `each` while 
`each!` should survive.
- `each_slice!` implementation is very slow. Possibly because `slice!` is O(n)?