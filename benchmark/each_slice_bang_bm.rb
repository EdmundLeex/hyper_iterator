require 'benchmark'
require_relative '../lib/hyper_iterator'

puts '---------------------------------------------------------'
puts '---------------------- each_slice! ----------------------'
puts '---------------------------------------------------------'
puts '--------------------- Memory Usage ----------------------'

arr = (1..10).to_a

before = ObjectSpace.count_objects
arr.each_slice(2) do |slice|
end
after = ObjectSpace.count_objects

puts 'Array#slice'
puts '----------------------'
puts "# of arrays: %d" % (after[:T_ARRAY] - before[:T_ARRAY])
puts "# of nodes: %d" % (after[:T_NODE] - before[:T_NODE])

puts

arr = (1..10).to_a

before = ObjectSpace.count_objects
arr.each_slice!(2) do |slice|
end
after = ObjectSpace.count_objects

puts 'Array#slice!'
puts '----------------------'
puts "# of arrays: %d" % (after[:T_ARRAY] - before[:T_ARRAY])
puts "# of nodes: %d" % (after[:T_NODE] - before[:T_NODE])

puts '---------------------------------------------------------'

puts '--------------- Execution Time Comparison ---------------'

n = 50000
arr = (1..10).to_a

Benchmark.bmbm(7) do |x|
  x.report('each_slice') { n.times { arr.each_slice(2) { |slice| nil } } }
  x.report('each_slice!') { n.times { arr.each_slice(2) { |slice| nil } } }
end

puts '---------------------------------------------------------'

puts