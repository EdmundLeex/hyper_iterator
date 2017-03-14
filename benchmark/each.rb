require 'memory_profiler'
require_relative '../lib/hyper_iterator'
$stdout.sync = true
puts '---------------------------------------------------------'
puts '--------------- Execution Time Comparison ---------------'
puts '------------------------- each --------------------------'

# GC.enable
n = 1
arr = Array.new(1_000) { '-' * 2000 }

report = MemoryProfiler.report do
  n.times { arr.each  { |el| sleep(0.1) } }
end

report.pretty_print

puts '---------------------------------------------------------'

puts