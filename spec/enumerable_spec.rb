# spec/enumerables_spec.rb

require_relative '../my_methods.rb'

RSpec.describe Enumerable do
  let(:test1) { [5, 4, 2] }
  let(:test2) { [3] }
  let(:test3) { [nil, true, 10] }
  let(:test4) { [1, 2, 3, 1, 2, 3, 4, 1, 2, 3] }
  let(:test5) { [false, false, false] }
  let(:test6) { {a:1, b:2, c:3, d:4, e:5} }
  let(:range) { (0..10) }

  describe '#my_each' do
    it 'should iterate through an array' do
      expect(test1.my_each { |x| p x + 1 }).to eql(test1.each { |x| p x + 1 })
      expect(test6.my_each { |k,v| p v + 1 }).to eql(test6.each { |k,v| p v + 1 })
      expect(range.my_each { |x| p x + 1 }).to eql(range.each { |x| p x + 1 })
    end
  end

  describe '#my_each_with_index' do
    it 'should iterate through an array and its index' do
      expect(test1.my_each_with_index { |x, y| x - y }).to eql(test1.each_with_index { |x, y| x - y })
      expect(range.my_each_with_index { |x, y| x - y }).to eql(range.each_with_index { |x, y| x - y })
    end
  end

  describe '#my_select' do
    it 'should create a new array based on the conditions passed at the block' do
      expect(test4.my_select { |x| x > 3 }).to eql([4])
      expect(test6.my_select { |k,v| v==5 }).to eql(test6.select { |k,v| v==5 })
      expect(range.my_select { |x| x > 10 }).to eql(nil)
    end
  end

  describe '#my_all?' do
    it 'should return true if all of the elements of the Enumerable pass the condition given by the block' do
      expect(test1.my_all? { |x| x == 1 }).to eql(test1.all? { |x| x == 1 })
      expect(test6.my_all? { |k,v| v==5 }).to eql(test6.all? { |k,v| v==5 })
      expect(range.my_all? { |x| x == 1 }).to eql(range.all? { |x| x == 1 })
    end
    it 'should not return true if any of the elements of the Enumerable pass the condition given by the block' do
      expect(test1.my_all? { |x| x < 1 }).not_to eql(true)
      expect(test6.my_all? { |k,v| v==5 } ).to eql(false)
      expect(range.my_all? { |x| x < 1 }).not_to eql(true)
    end
  end

  describe '#my_any?' do
    it 'should check whether the given condition is true for every item in the array' do
      expect(test3.my_any? { |x| x == true }).to eql(true)
      expect(test6.my_any? { |k,v| v==5 } ).to eql(true)
      expect(range.my_any? { |x| x == 3 }).to eql(true)
    end
    it "shouldn't return true if none of the elements of the Enumerable pass the condition given by the block" do
      expect(test5.my_any? { |x| x == true }).not_to eql(true)
      expect(test6.my_any? { |k,v| v==7 } ).to eql(false)
      expect(range.my_any? { |x| x == 11 }).to eql(false)
    end
  end

  describe '#my_none?' do
    it 'should check if the given condition is true for every item in the array' do
      expect(test4.my_none? { |x| x > 0 }).to eql(false)
      expect(test6.my_none? { |k,v| v==7 } ).to eql(true)
      expect(range.my_none? { |x| x > 0 }).to eql(false)
    end
    it 'should not return true check if the given condition is false for every item in the array' do
      expect(test4.my_none? { |x| x > 0 }).not_to eql(true)
      expect(test6.my_none? { |k,v| v==5 } ).to eql(false)
      expect(range.my_none? { |x| x > 0 }).not_to eql(true)
    end
  end

  describe '#my_map' do
    it 'should apply the logic of the block given to every element of the array' do
      expect(test1.my_map { |el| el**2 }).to eq([25, 16, 4])
      expect(test6.my_map { |k,v| v*0 } ).to eql([0, 0, 0, 0, 0])
      expect(range.my_map { |el| el**2 }).to eq(range.map { |el| el**2  })
    end
    it 'should\'t apply different logic of the block given to every element of the array' do
      expect(test1.my_map { |el| el**2 }).not_to eq([21, 6, 4])
      expect(test6.my_map { |k,v| v*0 } ).not_to eql({a:0, b:0, c:0, d:0, e:0})
      expect(range.my_map { |el| el**2 }).not_to eq([25, 16, 4])
    end
  end

  describe '#my_inject' do
    let(:array) { Array.new(10) { rand(0...10) } }
    let(:operation) { proc { |sum, n| sum + n } }

    context 'Test cases for my_all' do
      it 'should receive a proc without error' do
        expect(array.my_inject(&operation)).to eql(array.inject(&operation))
        expect(test6.my_inject(&operation)).to eql(test6.inject(&operation))
        expect(range.my_inject(&operation)).to eql(range.inject(&operation))
      end
      it 'should receive a math operator in parenthesis without error' do
        expect(array.my_inject(:+)).to eql(array.inject(:+))
        expect(test6.my_inject(:+)).to eql(test6.inject(:+))
        expect(range.my_inject(:+)).to eql(range.inject(:+))
      end
      it 'should receive an integer as the initial value and a math operator in parenthesis without error' do
        expect(array.my_inject(2, :*)).to eql(array.inject(2, :*))
        expect(range.my_inject(2, :*)).to eql(range.inject(2, :*))
      end
      it 'should receive blocks' do
        expect(array.my_inject(2) { |product, n| product * n }).to eql(array.inject(2) { |product, n| product * n })
        expect(range.my_inject(2) { |product, n| product * n }).to eql(range.inject(2) { |product, n| product * n })
      end
    end
  end
end
