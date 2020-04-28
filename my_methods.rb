module Enumerable
  def my_each
      return to_enum(:my_each) unless block_given?
      for num in self
        yield(num)
      end
  end

  def my_each_with_index
  end

  def my_select
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
puts "each without block: "
puts "Array-----"
p array.each
puts "Hash-----"
p hash.each
puts
puts "my_each without block: "
puts "Array-----"
p array.my_each
puts "Hash-----"
p hash.my_each
puts "-----------------------------------------------------------"
