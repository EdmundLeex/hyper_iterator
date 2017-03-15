require 'benchmark'
require_relative '../lib/hyper_iterator'
$stdout.sync = true

puts '---------------------------------------------------------'
puts '------------------------- each! -------------------------'
puts '---------------------- Should Pass ----------------------'

# GC.enable
n = 1
arr = Array.new(1_000) { '-' * 3000 }

Benchmark.bmbm(7) do |bm|
  bm.report('each!') { n.times { arr.each! { |el| '-' * 2 } } }
end

puts '---------------------------------------------------------'

puts