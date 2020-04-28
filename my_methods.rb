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
    for num in self
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
      self.each do |key,val| 
        if yield(key,val)
          hash[key]=val
        end
      end
     hash
    end
  end

  def my_all?
  end

  def my_any?
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
