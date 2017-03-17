require 'benchmark'
require_relative '../../lib/hyper_iterator'
$stdout.sync = true

puts
puts '----------------- Array#each! -----------------'
puts '#i    user      system      total       real'

base_arr = Array.new(10000) { '-' * 10 }
arrs = [base_arr]

i = 0
while true
  print "#{i} "
  arr = []
  report = Benchmark.measure do
    arrs[i].each! { |el| arr << el.dup }

    # Try to use this line and see how many more iterations you can get
    # Remember to uncomment line#24 as well.
    # You need to pop the array so the reference goes away.
    # arrs[0].each! { |el| arr << el.dup }
  end

  # Uncomment this to use with the above line#22
  # arrs.pop

  puts report
  arrs << arr
  i += 1
end
