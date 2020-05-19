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
    unless block_given?
      my_each { |val| return false if val == false || val.nil? }
      return true
    end
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
    unless block_given?
      my_each { |val| return true if val != false && !val.nil? }
      return false
    end

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
    unless block_given?
      my_each { |val| return false if val != false && !val.nil? }
      return true
    end

    my_each do |num|
      return false if yield(num)
    end
    true
  end

  def my_count(var = nil)
    i = 0
    unless var.nil?
      my_each { |val| i += 1 if val == var }
      return i
    end
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
    arr = !is_a?(Array) ? to_a.flatten : flatten
    res = in1.nil? || !in1.is_a?(Numeric) ? 0 : in1

    if in1.is_a?(Symbol)
      operator = in1
    elsif in2.is_a?(Symbol)
      operator = in2
    end

    if arr.my_all?(String)
      str = ''
      arr.my_each { |val| str = yield(str, val) }
      return str
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
  search = proc { |memo, word| memo.length > word.length ? memo : word }
  arr.my_inject(&search)
end

# rubocop: enable Metrics/ModuleLength
# rubocop: enable Metrics/PerceivedComplexity, Metrics/CyclomaticComplexity
