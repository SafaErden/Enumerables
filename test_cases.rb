hash = { 'a' => 5, 'b' => 4, 'c' => 2 }
array = [5, 4, 2]

test_one = proc { |val| puts "#{val}*2= #{val * 2}" }
test_two = proc { |key, val| puts "#{key}: #{val}*2= #{val * 2}" }
test_three = proc { |item, idx| puts "#{idx}: #{item}" }
test_four = proc { |val| val > 2 }
test_five = proc { |_key, val| val > 2 }

puts '-----------------------------------------------------------'
puts
puts 'my_each AND each METHOD COMPARISON'
puts
puts 'my_each with block: '
puts 'Array-----'
array.my_each(&test_one)
puts 'Hash-----'
hash.my_each(&test_two)
puts
puts 'each with block: '
puts 'Array-----'
array.each(&test_one)
puts 'Hash-----'
hash.each(&test_two)
puts
puts 'my_each without block: '
puts 'Array-----'
p array.my_each
puts 'Hash-----'
p hash.my_each
puts
puts 'each without block: '
puts 'Array-----'
p array.each
puts 'Hash-----'
p hash.each
puts '-----------------------------------------------------------'
puts
puts 'my_each_with_index AND each_with_index METHOD COMPARISON'
puts
puts 'my_each_with_index with block: '
puts 'Array-----'
array.my_each_with_index(&test_three)
puts 'Hash-----'
hash.my_each_with_index(&test_three)
puts
puts 'each_with_index with block: '
puts 'Array-----'
array.each_with_index(&test_three)
puts 'Hash-----'
hash.each_with_index(&test_three)
puts
puts 'my_each_with_index without block: '
puts 'Array-----'
p array.my_each_with_index
puts 'Hash-----'
p hash.my_each_with_index
puts
puts 'each_with_index without block: '
puts 'Array-----'
p array.each_with_index
puts 'Hash-----'
p hash.each_with_index
puts '-----------------------------------------------------------'
puts
puts 'my_select AND select METHOD COMPARISON'
puts
puts 'my_select with block: '
puts 'Array-----'
p array.my_select(&test_four)
puts 'Hash-----'
p hash.my_select(&test_five)
puts
puts 'select with block: '
puts 'Array-----'
p array.select(&test_four)
puts 'Hash-----'
p hash.select(&test_five)
puts
puts 'my_select without block: '
puts 'Array-----'
p array.my_select
puts 'Hash-----'
p hash.my_select
puts
puts 'select without block: '
puts 'Array-----'
p array.select
puts 'Hash-----'
p hash.select
puts '-----------------------------------------------------------'
puts
puts 'my_all? AND all? METHOD COMPARISON'
puts
puts 'my_all? with block: '
puts 'Array-----'
p array.my_all?(&test_four)
puts 'Hash-----'
p hash.my_all?(&test_five)
puts
puts 'all? with block: '
puts 'Array-----'
p array.all?(&test_four)
puts 'Hash-----'
p hash.all?(&test_five)
puts
puts 'my_all? without block: '
puts 'Array-----'
p array.my_all?
puts 'Hash-----'
p hash.my_all?
puts
puts 'all? without block: '
puts 'Array-----'
p array.all?
puts 'Hash-----'
p hash.all?
puts '-----------------------------------------------------------'
puts
puts 'my_any? AND any? METHOD COMPARISON'
puts
puts 'my_any? with block: '
puts 'Array-----'
p array.my_any?(&test_four)
puts 'Hash-----'
p hash.my_any?(&test_five)
puts
puts 'any? with block: '
puts 'Array-----'
p array.any?(&test_four)
puts 'Hash-----'
p hash.any?(&test_five)
puts
puts 'my_any? without block: '
puts 'Array-----'
p array.my_any?
puts 'Hash-----'
p hash.my_any?
puts
puts 'any? without block: '
puts 'Array-----'
p array.any?
puts 'Hash-----'
p hash.any?
puts '-----------------------------------------------------------'
puts
puts 'my_none? AND none? METHOD COMPARISON'
puts
puts 'my_none? with block: '
puts 'Array-----'
p array.my_none?(&test_four)
puts 'Hash-----'
p hash.my_none?(&test_five)
puts
puts 'none? with block: '
puts 'Array-----'
p array.none?(&test_four)
puts 'Hash-----'
p hash.none?(&test_five)
puts
puts 'my_none? without block: '
puts 'Array-----'
p array.my_none?
puts 'Hash-----'
p hash.my_none?
puts
puts 'none? without block: '
puts 'Array-----'
p array.none?
puts 'Hash-----'
p hash.none?
puts '-----------------------------------------------------------'
puts
puts 'my_count AND count METHOD COMPARISON'
puts
puts 'my_count with block: '
puts 'Array-----'
p array.my_count(&test_four)
puts 'Hash-----'
p hash.my_count(&test_five)
puts
puts 'count with block: '
puts 'Array-----'
p array.count(&test_four)
puts 'Hash-----'
p hash.count(&test_five)
puts
puts 'my_count without block: '
puts 'Array-----'
p array.my_count
puts 'Hash-----'
p hash.my_count
puts
puts 'count without block: '
puts 'Array-----'
p array.count
puts 'Hash-----'
p hash.count
puts '-----------------------------------------------------------'
puts
puts 'my_map AND map METHOD COMPARISON'
puts
puts 'my_map with block: '
puts 'Array-----'
p array.my_map(&test_four)
puts 'Hash-----'
p hash.my_map(&test_five)
puts
puts 'map with block: '
puts 'Array-----'
p array.map(&test_four)
puts 'Hash-----'
p hash.map(&test_five)
puts
puts 'my_map without block: '
puts 'Array-----'
p array.my_map
puts 'Hash-----'
p hash.my_map
puts
puts 'map without block: '
puts 'Array-----'
p array.map
puts 'Hash-----'
p hash.map
puts '-----------------------------------------------------------'
puts
puts 'my_inject AND inject METHOD COMPARISON'
puts
puts 'my_inject with block: '
puts 'Array-----'
p array.my_inject(5.0, :/) { |sum, n| sum * n }
puts 'Hash-----'
p hash.my_inject(5.0, :/) { |sum, n| sum * n }
puts
puts 'inject with block: '
puts 'Array-----'
p array.my_inject(5.0, :/) { |sum, n| sum * n }
puts 'Hash-----'
p hash.my_inject(5.0, :/) { |sum, n| sum * n }
puts
puts 'my_inject without block: '
puts 'Array-----'
p array.my_inject
puts 'Hash-----'
p hash.my_inject
puts '-----------------------------------------------------------'
