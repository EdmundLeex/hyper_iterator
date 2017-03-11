require 'benchmark'
require_relative '../lib/hyper_iterator'

class Thing; end

puts '---------------------------------------------------------'
puts '---------------------- each_slice! ----------------------'

puts '---------------------------------------------------------'
puts '------------------ Garbage Collection -------------------'

slize_size = rand(1..10)

puts 'Array#slice'
puts '----------------------'

arr = Array.new(100) { Thing.new }
line = ''

arr.each_slice(slize_size) do |slice|
  GC.start
  print ObjectSpace.each_object(Thing).count
  print ' '
end

puts
puts

puts 'Array#slice!'
puts '----------------------'

arr = Array.new(100) { Thing.new }

arr.each_slice!(slize_size) do |slice|
  GC.start
  print ObjectSpace.each_object(Thing).count
  print ' '
end

puts

puts '---------------------------------------------------------'
puts '-------------------- Objects Created --------------------'


GC.disable
arr = Array.new(1000) { Thing.new }

before = ObjectSpace.count_objects
arr.each_slice(slize_size) do |slice|
end
after = ObjectSpace.count_objects

puts 'Array#slice'
puts '----------------------'
puts "# of arrays: %d" % (after[:T_ARRAY] - before[:T_ARRAY])
puts "# of nodes: %d" % (after[:T_NODE] - before[:T_NODE])

puts

arr = Array.new(1000) { Thing.new }

before = ObjectSpace.count_objects
arr.each_slice!(slize_size) do |slice|
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