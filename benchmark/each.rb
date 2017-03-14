require 'benchmark'
require_relative '../lib/hyper_iterator'

puts '---------------------------------------------------------'
puts '--------------- Execution Time Comparison ---------------'
puts '------------------------- each --------------------------'

# GC.enable
n = 1
arr = Array.new(1_000) { '-' * 3200 }

Benchmark.bmbm(7) do |x|
  x.report('each')  { n.times { arr.each  { |el| sleep(1) } } }
end

puts '---------------------------------------------------------'

puts