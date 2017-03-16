# require 'benchmark'
require_relative '../lib/hyper_iterator'
$stdout.sync = true

puts 'Array#each'
puts 'creating array'
arr = Array.new(10000) { '-' * 100 }
arr_1 = []
puts 'finished creating array'
puts 'each iteration begins'

i = 0
arr.each! do |el|
  new_el = '+' * 100
  arr_1 << new_el
  # i += 1
  # print "#{i} "
end

puts 'finished iteration'

puts