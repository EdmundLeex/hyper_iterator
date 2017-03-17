[![Build Status](https://travis-ci.org/EdmundLeex/hyper_iterator.svg?branch=master)](https://travis-ci.org/EdmundLeex/hyper_iterator)

# HyperIterator

**Caution: this gem monkey patches Ruby's `Array` class.**

Inspired by [Ruby Performance Optimization](https://media.pragprog.com/titles/adrpo/iterators.pdf), 
HyperIterator is reimplementation of Ruby iterators in Ruby, designed to address performance 
drawbacks from native implementations, mainly in memory usage.

The main idea is to remove objects from array during iteration. In iteration of large array, 
this would allow garbage collection to happen before the iteration finishes, therefore reduce 
memory usage.

## Installation

*This is in experimental stage, therefore not available as a gem yet. More testing will be conducted.*
*You can see my [updates in here](UPDATE.md)*

<!-- Add this line to your application's Gemfile:

```ruby
gem 'hyper_iterator'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install hyper_iterator
 -->
## Available Methods (adding more)

- `each_slice!`
- `each!`

## Gotcha

These methods work just as the non bang version, except that, it **WILL MUTATE** the original array 
by **REMOVING ALL** the elements from it.

```ruby
arr = (1..10).to_a
arr.each! { |el| ... }
# After the iteration, the arr is empty!
# arr => []
```

## Benchmark

### For basic benchmarks
```
rake benchmark
```

#### Example report

```
---------------------------------------------------------
---------------------- each_slice! ----------------------
---------------------------------------------------------
------------------ Garbage Collection -------------------
Array#each_slice
----------------------
100 100 100 100 100 100 100 100 100 100 100 100 100

Array#each_slice!
----------------------
100 92 84 76 68 60 52 44 36 28 20 12 4
---------------------------------------------------------
-------------------- Objects Created --------------------
Array#each_slice
----------------------
# of arrays: 126
# of nodes: 2

Array#each_slice!
----------------------
# of arrays: 125
# of nodes: 0
---------------------------------------------------------
--------------- Execution Time Comparison ---------------
Rehearsal -----------------------------------------------
each_slice    0.040000   0.000000   0.040000 (  0.049524)
each_slice!   0.040000   0.010000   0.050000 (  0.047753)
-------------------------------------- total: 0.090000sec

                  user     system      total        real
each_slice    0.040000   0.010000   0.050000 (  0.048487)
each_slice!   0.040000   0.010000   0.050000 (  0.052009)
---------------------------------------------------------
```

### Memory Benchmark

To eliminate the variable of different machines, you will need to install [Docker](https://docs.docker.com/engine/installation/) 
for this.

1. Go to [Docker](https://docs.docker.com/engine/installation/) to download and install Docker
2. Go to the `Dockerfile`, and pick a Ruby version of your choice
3. Run `bin/setup` in your command line
4. Run `bin/bm` in your command line

#### Methodology

The native implementation (non bang version) retains the entire array. So if we keep on adding objects to 
memory, it will blow up pretty quickly (given the memory is limited).

While using the bang version in this gem, the refernce to the objects store in the array will be removed. 
So the Garbage Collector (GC) can see them as removable objects and clean them up.

The test code simply creates duplicate object as it iterates. Since the bang version iterator keeps removing 
the references, the memory gets to recycle itself. In this repot, it will show as more iterations compare 
to the non bang version.

This is because as the memory gets freed up, we just have more rooms to store new objects, until the GC is 
not freeing up memory fast enough.

FYI: In this test, the empty array (created from every iteration to store the new objects) is also otaking 
up more space. If you pop the empty array off (see [./benchmark/memory_bm/each_bang.rb](./benchmark/memory_bm/each_bang.rb)), 
you can get a lot more iterations!

#### Example report

- #i is the nth iteration
- The rest is time spent in execution
- The last line is empty because memory blew up

```
----------------- Array#each ------------------
#i    user      system      total       real
0   0.010000   0.000000   0.010000 (  0.043329)
1   0.000000   0.010000   0.010000 (  0.010112)
2   0.000000   0.000000   0.000000 (  0.025059)
3   0.000000   0.000000   0.000000 (  0.010436)
4   0.000000   0.000000   0.000000 (  0.008007)
5   0.000000   0.010000   0.010000 (  0.009692)
6   0.000000   0.010000   0.010000 (  0.050283)
7
----------------- Array#each! -----------------
#i    user      system      total       real
0   0.000000   0.000000   0.000000 (  0.004570)
1   0.010000   0.000000   0.010000 (  0.006715)
2   0.000000   0.010000   0.010000 (  0.040050)
3   0.010000   0.000000   0.010000 (  0.009338)
4   0.000000   0.000000   0.000000 (  0.006622)
5   0.000000   0.010000   0.010000 (  0.019370)
6   0.000000   0.000000   0.000000 (  0.012097)
7   0.000000   0.010000   0.010000 (  0.025825)
8   0.000000   0.010000   0.010000 (  0.014587)
9   0.000000   0.010000   0.010000 (  0.014893)
10   0.000000   0.000000   0.000000 (  0.026595)
11   0.000000   0.000000   0.000000 (  0.012371)
12   0.010000   0.000000   0.010000 (  0.023964)
13   0.000000   0.000000   0.000000 (  0.007783)
14   0.000000   0.000000   0.000000 (  0.004344)
15   0.010000   0.020000   0.030000 (  0.119632)
16   0.000000   0.010000   0.010000 (  0.010222)
17   0.000000   0.000000   0.000000 (  0.009091)
18 %
```

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake test` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/edmundleex/hyper_iterator. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [Contributor Covenant](http://contributor-covenant.org) code of conduct.


## License

The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).

