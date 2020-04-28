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
    self.my_each do |num|
      yield(num,i)
      i+=1
    end
  end

  def my_select
    return to_enum(:my_select) unless block_given?
    if self.is_a?(Array)
      arr=[]
      self.my_each do |num| 
       if yield(num)
        arr<<num
       end
      end
    arr
    elsif self.is_a?(Hash)
      hash={}
      self.my_each do |key,val| 
        if yield(key,val)
          hash[key]=val
        end
      end
     hash
    end
  end

  def my_all?
    return true unless block_given?
    self.my_each do |num| 
    if !yield(num)
    return false
    end
   end
   true
  end

  def my_any?
    return true unless block_given?
    self.my_each do |num| 
    if !yield(num)
    return true
    end
   end
   false
  end

  def my_none?
  end

  def my_count
  end

  def my_map
  end

  def my_inject
  end
end

hash = {"a"=>5,"b"=>4,"c"=>2}
array= [5,4,2]

puts "-----------------------------------------------------------"
puts
puts "my_each AND each METHOD COMPARISON"
puts
puts "my_each with block: "
puts "Array-----"
array.my_each{|val| puts "#{val}*2= #{val*2}"}
puts "Hash-----"
hash.my_each{|key,val| puts "#{key}: #{val}*2= #{val*2}"}
puts 
puts "each with block: "
puts "Array-----"
array.each{|val| puts "#{val}*2= #{val*2}"}
puts "Hash-----"
hash.each{|key,val| puts "#{key}: #{val}*2= #{val*2}"}
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
array.my_each_with_index{|item,idx| puts "#{idx}: #{item}"}
puts "Hash-----"
hash.my_each_with_index{|item,idx| puts "#{idx}: #{item}"}
puts 
puts "each_with_index with block: "
puts "Array-----"
array.each_with_index{|item,idx| puts "#{idx}: #{item}"}
puts "Hash-----"
hash.each_with_index{|item,idx| puts "#{idx}: #{item}"}
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
p array.my_select{|val| val>2}
puts "Hash-----"
p hash.my_select{|key,val| val>2}
puts 
puts "select with block: "
puts "Array-----"
p array.select{|val| val>2}
puts "Hash-----"
p hash.select{|key,val| val>2}
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
p array.my_all?{|val| val>2}
puts "Hash-----"
p hash.my_all?{|key,val| val>2}
puts 
puts "all? with block: "
puts "Array-----"
p array.all?{|val| val>2}
puts "Hash-----"
p hash.all?{|key,val| val>2}
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
p array.my_any?{|val| val>2}
puts "Hash-----"
p hash.my_any?{|key,val| val>2}
puts 
puts "any? with block: "
puts "Array-----"
p array.any?{|val| val>2}
puts "Hash-----"
p hash.any?{|key,val| val>2}
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
