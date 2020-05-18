# spec/enumerables_spec.rb

require_relative '../my_methods.rb'

RSpec.describe Enumerable do
  let(:test1) { [5, 4, 2] }
  let(:test2) { [3] }
  let(:test3) { [nil, true, 10] }
  let(:test4) { [1, 2, 3, 1, 2, 3, 4, 1, 2, 3] }

  describe '#my_each' do
    it 'should interate through an array' do
      expect(test1.my_each { |x| p x }).to eql(test1.each { |x| p x })
      expect(test1.my_each { |x| p x * 2 }).to eql(test1.each { |x| p x * 2 })
      expect(test1.my_each { |x| p x * 4 }).to eql(test1.each { |x| p x * 4 })
    end
  end

  describe '#my_each_with_index' do
    it 'should interate through an array and its index' do
      expect(test1.my_each_with_index { |x, y| x + y }).to eql(test1.each_with_index { |x, y| x + y })
      expect(test1.my_each_with_index { |x, y| x * y }).to eql(test1.each_with_index { |x, y| x * y })
      expect(test1.my_each_with_index { |x, y| x - y }).to eql(test1.each_with_index { |x, y| x - y })
    end
  end

  describe '#my_select' do
    it 'should create a new array based on the conditions passed at the block' do
      expect(test2.my_select { |x| x == 1 }).to eql([])
      expect(test3.my_select { |x| x == true }).to eql([true])
      expect(test4.my_select { |x| x == 1 }).to eql([1, 1, 1])
      expect(test4.my_select { |x| x > 3 }).to eql([4])
    end
  end

  describe '#my_all?' do
    it 'should check when the given condition is true for the itens in the array' do
      expect(test1.my_all? { |x| x == 1 }).to eql(false)
      expect(test1.my_all? { |x| x > 0 }).to eql(true)
      expect(test1.my_all? { |x| x == true }).to eql(false)
    end
  end

  describe '#my_any?' do
    it 'should check whether the given condition is true for every item in the array' do
      expect(test3.my_any? { |x| x == true }).to eql(true)
      expect(test4.my_any? { |x| x == true }).to eql(false)
      expect(test4.my_any? { |x| x > 0 }).to eql(true)
    end
  end

  describe '#my_none?' do
    it 'should check if the given condition is true for every item in the array' do
      expect(test3.my_none? { |x| x == true }).to eql(false)
      expect(test4.my_none? { |x| x == true }).to eql(true)
      expect(test4.my_none? { |x| x > 0 }).to eql(false)
    end
  end

  describe '#my_map' do
    it 'should apply the logic of the block given to every element of the array' do
      expect(test1.my_map { |el| el**2 }).to eq([25, 16, 4])
    end
  end

  describe '#my_inject' do
    let(:array) { Array.new(10) { rand(0...10) } }
    let(:operation) { proc { |sum, n| sum + n } }

    context 'Test cases for my_all' do
      it 'Array.new(10) { rand(0...10).my_inject(proc { |sum, n| sum + n }) ' do
        expect(array.my_inject(&operation)).to eql(array.inject(&operation))
      end
      it 'Array.new(10) { rand(0...10).my_inject(:+)' do
        expect(array.my_inject(:+)).to eql(array.inject(:+))
      end
      it 'Array.new(10) { rand(0...10).my_inject(2,:*)' do
        expect(array.my_inject(2, :*)).to eql(array.inject(2, :*))
      end
      it 'Array.new(10) { rand(0...10).my_inject(2){|product, n| product * n}' do
        expect(array.my_inject(2) { |product, n| product * n }).to eql(array.inject(2) { |product, n| product * n })
      end
    end
  end
end
