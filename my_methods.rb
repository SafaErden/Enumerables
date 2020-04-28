# rubocop: disable Metrics/ModuleLength
# rubocop: disable Metrics/PerceivedComplexity, Metrics/CyclomaticComplexity

module Enumerable
  def my_each
    return to_enum(:my_each) unless block_given?
    for num in self
      yield(num)
    end
  end

  def my_each_with_index
    return to_enum(:my_each_with_index) unless block_given?
    i=0
    my_each do |num|
      yield(num,i)
      i+=1
    end
  end

  def my_select
    return to_enum(:my_select) unless block_given?
    if self.is_a?(Array)
      arr=[]
      my_each do |num| 
       if yield(num)
        arr<<num
       end
      end
    arr
    elsif self.is_a?(Hash)
      hash={}
      my_each do |key,val| 
        if yield(key,val)
          hash[key]=val
        end
      end
     hash
    end
  end

  def my_all?(var=nil)
    if var!=nil
      if var.is_a?(Regexp)
        my_each{|val| return false if !val.match(var)}
      elsif var.is_a?(Module)
        my_each{|val| return false if !val.is_a?(var)}
      else
        my_each{|val| return false if val!=var}
      end
      return true
    end
    return true unless block_given?
    my_each do |num| 
      if !yield(num)
        return false
      end
    end
    true
  end

  def my_any?(var=nil)
    if var!=nil
      if var.is_a?(Regexp)
        my_each{|val| return true if val.match(var)}
      elsif var.is_a?(Module)
        my_each{|val| return true if val.is_a?(var)}
      else
        my_each{|val| return true if val==var}
      end
      return false
    end
    return true unless block_given?
    my_each do |num| 
    if yield(num)
    return true
    end
   end
   false
  end

  def my_none?(var=nil)
    if var!=nil
      if var.is_a?(Regexp)
        my_each{|val| return false if val.match(var)}
      elsif var.is_a?(Module)
        my_each{|val| return false if val.is_a?(var)}
      else
        my_each{|val| return false if val==var}
      end
      return true
    end
    return false unless block_given?
    my_each do |num| 
    if yield(num)
    return false
    end
   end
   true
  end

  def my_count
    return self.size unless block_given?
    i=0
    my_each do |num| 
    if yield(num)
    i+=1
    end
   end
   i
  end

  def my_map(var=nil)
    arr=[]
    if var.is_a?(Proc)
      if self.is_a?(Array)
        my_each do |num| 
         arr<<var.call(num)
        end
      elsif self.is_a?(Hash)
        my_each do |key,val| 
          arr<<var.call(num)
        end
      end
      return arr
    end

    return to_enum(:my_map) unless block_given?
    
    if self.is_a?(Array)
      my_each do |num| 
       arr<<yield(num)
      end
    elsif self.is_a?(Hash)
      my_each do |key,val| 
        arr<<yield(key,val)
      end
    end
    arr
  end

  def my_inject(in1=nil,in2=nil)
    return to_enum(:my_inject) unless block_given?
    i=0
    if self.is_a?(Array)
      my_each do |num| 
       i+=yield(num)
      end
    elsif self.is_a?(Hash)
      my_each do |key,val| 
        i+=yield(key,val)
      end
    end
    i
  end
end

# rubocop: enable Metrics/ModuleLength
# rubocop: enable Metrics/PerceivedComplexity, Metrics/CyclomaticComplexity

hash = {"a"=>5,"b"=>4,"c"=>2}
array= [5,4,2]

test_1=Proc.new {|val| puts "#{val}*2= #{val*2}"}
test_2=Proc.new {|key,val| puts "#{key}: #{val}*2= #{val*2}"}
test_3=Proc.new {|item,idx| puts "#{idx}: #{item}"}
test_4=Proc.new {|val| val>2}
test_5=Proc.new {|key,val| val>2}

puts "-----------------------------------------------------------"
puts
puts "my_each AND each METHOD COMPARISON"
puts
puts "my_each with block: "
puts "Array-----"
array.my_each(&test_1)
puts "Hash-----"
hash.my_each(&test_2)
puts 
puts "each with block: "
puts "Array-----"
array.each(&test_1)
puts "Hash-----"
hash.each(&test_2)
puts
puts "my_each without block: "
puts "Array-----"
p array.my_each
puts "Hash-----"
p hash.my_each
puts
puts "each without block: "
puts "Array-----"
p array.each
puts "Hash-----"
p hash.each
puts "-----------------------------------------------------------"
puts
puts "my_each_with_index AND each_with_index METHOD COMPARISON"
puts
puts "my_each_with_index with block: "
puts "Array-----"
array.my_each_with_index(&test_3)
puts "Hash-----"
hash.my_each_with_index(&test_3)
puts 
puts "each_with_index with block: "
puts "Array-----"
array.each_with_index(&test_3)
puts "Hash-----"
hash.each_with_index(&test_3)
puts
puts "my_each_with_index without block: "
puts "Array-----"
p array.my_each_with_index
puts "Hash-----"
p hash.my_each_with_index
puts
puts "each_with_index without block: "
puts "Array-----"
p array.each_with_index
puts "Hash-----"
p hash.each_with_index
puts "-----------------------------------------------------------"
puts
puts "my_select AND select METHOD COMPARISON"
puts
puts "my_select with block: "
puts "Array-----"
p array.my_select(&test_4)
puts "Hash-----"
p hash.my_select(&test_5)
puts 
puts "select with block: "
puts "Array-----"
p array.select(&test_4)
puts "Hash-----"
p hash.select(&test_5)
puts
puts "my_select without block: "
puts "Array-----"
p array.my_select
puts "Hash-----"
p hash.my_select
puts
puts "select without block: "
puts "Array-----"
p array.select
puts "Hash-----"
p hash.select
puts "-----------------------------------------------------------"
puts
puts "my_all? AND all? METHOD COMPARISON"
puts
puts "my_all? with block: "
puts "Array-----"
p array.my_all?(&test_4)
puts "Hash-----"
p hash.my_all?(&test_5)
puts 
puts "all? with block: "
puts "Array-----"
p array.all?(&test_4)
puts "Hash-----"
p hash.all?(&test_5)
puts
puts "my_all? without block: "
puts "Array-----"
p array.my_all?
puts "Hash-----"
p hash.my_all?
puts
puts "all? without block: "
puts "Array-----"
p array.all?
puts "Hash-----"
p hash.all?
puts "-----------------------------------------------------------"
puts
puts "my_any? AND any? METHOD COMPARISON"
puts
puts "my_any? with block: "
puts "Array-----"
p array.my_any?(&test_4)
puts "Hash-----"
p hash.my_any?(&test_5)
puts 
puts "any? with block: "
puts "Array-----"
p array.any?(&test_4)
puts "Hash-----"
p hash.any?(&test_5)
puts
puts "my_any? without block: "
puts "Array-----"
p array.my_any?
puts "Hash-----"
p hash.my_any?
puts
puts "any? without block: "
puts "Array-----"
p array.any?
puts "Hash-----"
p hash.any?
puts "-----------------------------------------------------------"
puts
puts "my_none? AND none? METHOD COMPARISON"
puts
puts "my_none? with block: "
puts "Array-----"
p array.my_none?(&test_4)
puts "Hash-----"
p hash.my_none?(&test_5)
puts 
puts "none? with block: "
puts "Array-----"
p array.none?(&test_4)
puts "Hash-----"
p hash.none?(&test_5)
puts
puts "my_none? without block: "
puts "Array-----"
p array.my_none?
puts "Hash-----"
p hash.my_none?
puts
puts "none? without block: "
puts "Array-----"
p array.none?
puts "Hash-----"
p hash.none?
puts "-----------------------------------------------------------"
puts
puts "my_count AND count METHOD COMPARISON"
puts
puts "my_count with block: "
puts "Array-----"
p array.my_count(&test_4)
puts "Hash-----"
p hash.my_count(&test_5)
puts 
puts "count with block: "
puts "Array-----"
p array.count(&test_4)
puts "Hash-----"
p hash.count(&test_5)
puts
puts "my_count without block: "
puts "Array-----"
p array.my_count
puts "Hash-----"
p hash.my_count
puts
puts "count without block: "
puts "Array-----"
p array.count
puts "Hash-----"
p hash.count
puts "-----------------------------------------------------------"
puts
puts "my_map AND map METHOD COMPARISON"
puts
puts "my_map with block: "
puts "Array-----"
p array.my_map(&test_4)
puts "Hash-----"
p hash.my_map(&test_5)
puts 
puts "map with block: "
puts "Array-----"
p array.map(&test_4)
puts "Hash-----"
p hash.map(&test_5)
puts
puts "my_map without block: "
puts "Array-----"
p array.my_map
puts "Hash-----"
p hash.my_map
puts
puts "map without block: "
puts "Array-----"
p array.map
puts "Hash-----"
p hash.map
puts "-----------------------------------------------------------"
puts
puts "my_inject AND inject METHOD COMPARISON"
puts
puts "my_inject with block: "
puts "Array-----"
#p array.my_inject{|val| val>2}
puts "Hash-----"
#p hash.my_inject{|key,val| key=2}
puts 
puts "inject with block: "
puts "Array-----"
p array.inject {|sum, n| sum + n } 
puts "Hash-----"
p hash.inject {|sum, n| sum + n } 
puts
puts "my_inject without block: "
puts "Array-----"
#p array.my_inject
puts "Hash-----"
#p hash.my_inject
puts
puts "inject without block: "
puts "Array-----"
#p array.inject
puts "Hash-----"
#p hash.inject
puts "-----------------------------------------------------------"
p [nil, false, true, []].my_none? # should return false
p %w[dog bird fish].my_none?(5) # should return true
p [3, 3, 3].my_all?(3<1) # should return true
p %w[1 2 3].my_none?(String) # should return false