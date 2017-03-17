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

These methods work just as the non bang version, except that, it **WILL MUTATE** the original array 
by **REMOVING ALL** the elements from it.

- `each_slice!`
- `each!`

## Benchmark

### For basic benchmarks
```
rake benchmark
```

Example report

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

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake test` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/edmundleex/hyper_iterator. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [Contributor Covenant](http://contributor-covenant.org) code of conduct.


## License

The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).

