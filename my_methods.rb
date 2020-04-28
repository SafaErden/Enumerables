# rubocop: disable Metrics/ModuleLength
# rubocop: disable Metrics/PerceivedComplexity, Metrics/CyclomaticComplexity

module Enumerable
  def my_each
    return to_enum(:my_each) unless block_given?

    each do |num|
      yield(num)
    end
  end

  def my_each_with_index
    return to_enum(:my_each_with_index) unless block_given?

    i = 0
    my_each do |num|
      yield(num, i)
      i += 1
    end
  end

  def my_select
    return to_enum(:my_select) unless block_given?

    if is_a?(Array)
      arr = []
      my_each do |num|
        arr << num if yield(num)
      end
      arr
    elsif is_a?(Hash)
      hash = {}
      my_each do |key, val|
        hash[key] = val if yield(key, val)
      end
      hash
    end
  end

  def my_all?(var = nil)
    unless var.nil?
      if var.is_a?(Regexp)
        my_each { |val| return false unless val.match(var) }
      elsif var.is_a?(Module)
        my_each { |val| return false unless val.is_a?(var) }
      else
        my_each { |val| return false if val != var }
      end
      return true
    end
    return true unless block_given?

    my_each do |num|
      return false unless yield(num)
    end
    true
  end

  def my_any?(var = nil)
    unless var.nil?
      if var.is_a?(Regexp)
        my_each { |val| return true if val.match(var) }
      elsif var.is_a?(Module)
        my_each { |val| return true if val.is_a?(var) }
      else
        my_each { |val| return true if val == var }
      end
      return false
    end
    return true unless block_given?

    my_each do |num|
      return true if yield(num)
    end
    false
  end

  def my_none?(var = nil)
    unless var.nil?
      if var.is_a?(Regexp)
        my_each { |val| return false if val.match(var) }
      elsif var.is_a?(Module)
        my_each { |val| return false if val.is_a?(var) }
      else
        my_each { |val| return false if val == var }
      end
      return true
    end
    return false unless block_given?

    my_each do |num|
      return false if yield(num)
    end
    true
  end

  def my_count
    return size unless block_given?

    i = 0
    my_each do |num|
      i += 1 if yield(num)
    end
    i
  end

  def my_map(var = nil)
    arr = []
    if var.is_a?(Proc)
      if is_a?(Array)
        my_each { |num| arr << var.call(num) }
      elsif is_a?(Hash)
        my_each { |_key, _val| arr << var.call(num) }
      end
      return arr
    end

    return to_enum(:my_map) unless block_given?

    if is_a?(Array)
      my_each { |num| arr << yield(num) }
    elsif is_a?(Hash)
      my_each { |key, val| arr << yield(key, val) }
    end
    arr
  end

  def my_inject(in1 = nil, in2 = nil)
    res = 0
    arr = !is_a?(Array) ? to_a.flatten : flatten
    operator = nil
    res = in1.nil? || !in1.is_a?(Numeric) ? 0 : in1
    return to_enum(:my_inject) if in1.nil? && in2.nil? && !block_given?

    if in1.is_a?(Symbol)
      operator = in1
    elsif in2.is_a?(Symbol)
      operator = in2
    end

    arr.my_each { |num| return arr unless num.is_a?(Numeric) }

    unless operator.nil?
      arr.my_each { |num| res = res.send(operator, num) }
      return res
    end

    return to_enum(:my_inject) unless block_given?

    arr.my_each { |num| res = yield(res, num) }
    res
  end
end

def multiply_els(arr)
  arr.my_inject(:+)
end

# rubocop: enable Metrics/ModuleLength
# rubocop: enable Metrics/PerceivedComplexity, Metrics/CyclomaticComplexity

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
puts 'TEST my_inject with multiply_els METHOD'
p multiply_els(array)
