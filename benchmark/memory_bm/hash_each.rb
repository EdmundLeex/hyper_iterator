require 'benchmark'
require_relative '../../lib/hyper_iterator'
$stdout.sync = true

puts
puts '----------------- Hash#each! -----------------'
puts '#i    user      system      total       real'

base_hash = {}
1000.times { |i| base_hash["k#{i}"] = '-' * 10 }
hashes = [base_hash]

i = 0
while true
  print "#{i} "
  hash = {}
  report = Benchmark.measure do
    hashes[i].each do |k, v|
      hash[k.dup] = v.dup
    end

    # Try to use this line and see how many more iterations you can get
    # Remember to uncomment line#24 as well.
    # You need to pop the array so the reference goes away.
    # arrs[0].each! { |el| arr << el.dup }
  end

  # Uncomment this to use with the above line#22
  # arrs.pop

  puts report
  hashes << hash
  i += 1
end
