require 'benchmark'
require_relative '../../lib/hyper_iterator'
$stdout.sync = true

puts
puts '----------------- Array#each ------------------'
puts '#i    user      system      total       real'

base_arr = Array.new(10000) { '-' * 10 }
arrs = [base_arr]

i = 0
while true
  print "#{i} "
  arr = []
  report = Benchmark.measure do
    arrs[i].each { |el| arr << el.dup }
  end

  puts report
  arrs << arr
  i += 1
end
