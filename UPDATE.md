### 3/14/17

- Testing benchmark in containerized environment to simulate limited allocated memory.
- `each!` seems to be working fine. I can see gradual memory release in docker stat even
not by a large margin.
- Next thing to test would be creating more objects within the iteration to use up more 
memory. Given that with 4MB allocation, the current [./benchmark/each.rb](benchmark/each.rb) 
and [./benchmark/each_bang.rb](benchmark/each_bang.rb) is running at the edge of using up 
all memory, creating more objects supposedly would kill the process using `each` while 
`each!` should survive.