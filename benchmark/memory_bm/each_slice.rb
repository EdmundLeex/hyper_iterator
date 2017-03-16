require 'benchmark'
require_relative '../../lib/hyper_iterator'
$stdout.sync = true

puts 'Array#each_slice'
puts 'creating array'
base_arr = Array.new(10000) { '-' * 10 }
arrs = [base_arr]
puts 'finished creating base array'
puts 'each iteration begins'

i = 0
while true
  print "#{i} "
  arr = []
  report = Benchmark.measure do
    arrs[i].each_slice(100) do |sl|
      sl.each { |el| arr << el.dup }
    end
  end

  puts report
  arrs << arr
  i += 1
end

puts