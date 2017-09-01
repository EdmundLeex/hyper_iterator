require 'benchmark'
require_relative '../lib/hyper_iterator'

class Key; end
class Val; end

puts '---------------------------------------------------------'
puts '------------------------- each! -------------------------'

puts '---------------------------------------------------------'
puts '------------------ Garbage Collection -------------------'

puts 'Hash#each'
puts '----------------------'

hash = {}
100.times do
  hash[Key.new] = Val.new
end

hash.each do |_|
  GC.start
  print ObjectSpace.each_object(Key).count
  print ' '
  print ObjectSpace.each_object(Val).count
  print ' '
end

puts
puts

puts 'Hash#each!'
puts '----------------------'

hash = {}
100.times do
  hash[Key.new] = Val.new
end

hash.each! do |_|
  GC.start
  print ObjectSpace.each_object(Key).count
  print ' '
  print ObjectSpace.each_object(Val).count
  print ' '
end

puts

puts '---------------------------------------------------------'
puts '-------------------- Objects Created --------------------'


GC.disable
hash = {}
100.times do
  hash[Key.new] = Val.new
end

before = ObjectSpace.count_objects
hash.each do |_|
end
after = ObjectSpace.count_objects

puts 'Hash#each'
puts '----------------------'
puts "# of arrays: %d" % (after[:T_ARRAY] - before[:T_ARRAY])
puts "# of nodes: %d" % (after[:T_NODE] - before[:T_NODE])

puts

hash = {}
100.times do
  hash[Key.new] = Val.new
end

before = ObjectSpace.count_objects
hash.each! do |el|
end
after = ObjectSpace.count_objects

puts 'Hash#each!'
puts '----------------------'
puts "# of arrays: %d" % (after[:T_ARRAY] - before[:T_ARRAY])
puts "# of nodes: %d" % (after[:T_NODE] - before[:T_NODE])

puts '---------------------------------------------------------'
puts '--------------- Execution Time Comparison ---------------'

GC.enable
n = 10
hash = {}
10_000.times do
  hash[Key.new] = Val.new
end

Benchmark.bmbm(7) do |x|
  x.report('each!') { n.times { hash.each! { |el| nil } } }
  x.report('each')  { n.times { hash.each  { |el| nil } } }
end

puts '---------------------------------------------------------'

puts