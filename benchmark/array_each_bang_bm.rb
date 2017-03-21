require 'benchmark'
require_relative '../lib/hyper_iterator'

class Thing; end

puts '---------------------------------------------------------'
puts '------------------------- each! -------------------------'

puts '---------------------------------------------------------'
puts '------------------ Garbage Collection -------------------'

puts 'Array#each'
puts '----------------------'

arr = Array.new(100) { Thing.new }

arr.each do |el|
  GC.start
  print ObjectSpace.each_object(Thing).count
  print ' '
end

puts
puts

puts 'Array#each!'
puts '----------------------'

arr = Array.new(100) { Thing.new }

arr.each! do |el|
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
arr.each do |el|
end
after = ObjectSpace.count_objects

puts 'Array#each'
puts '----------------------'
puts "# of arrays: %d" % (after[:T_ARRAY] - before[:T_ARRAY])
puts "# of nodes: %d" % (after[:T_NODE] - before[:T_NODE])

puts

arr = Array.new(1000) { Thing.new }

before = ObjectSpace.count_objects
arr.each! do |el|
end
after = ObjectSpace.count_objects

puts 'Array#each!'
puts '----------------------'
puts "# of arrays: %d" % (after[:T_ARRAY] - before[:T_ARRAY])
puts "# of nodes: %d" % (after[:T_NODE] - before[:T_NODE])

puts '---------------------------------------------------------'
puts '--------------- Execution Time Comparison ---------------'

GC.enable
n = 10
arr = Array.new(1_000_000) { Thing.new }

Benchmark.bmbm(7) do |x|
  x.report('each!') { n.times { arr.each! { |el| nil } } }
  x.report('each')  { n.times { arr.each  { |el| nil } } }
end

puts '---------------------------------------------------------'

puts