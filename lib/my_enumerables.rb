# You will first have to define my_each
# on the Array class. Methods defined in
# your enumerable module will have access
# to this method
class Array
  include Enumerable
  # Define my_each here
  def my_each
    for i in 0...self.length
      yield(self[i])
    end
    self
  end
end

module Enumerable
  def my_all?
    self.my_each do |value| 
      unless yield(value)
        return false
      end
    end
    return true
  end

  def my_any?
    self.my_each do |value|
      if yield(value)
        return true
      end
    end 
    return false
  end

  def my_count(&block)
    unless block
      self.length
    else
      count = 0 
      self.my_each do |value|
        if yield(value)
          count += 1 
        end
      end
     count
    end
  end

  def my_each_with_index
    for i in 0...self.length
      yield(self[i], i)
    end
    self
  end

  def my_inject(sum = 0)
    self.my_each do |value|
      sum = yield(sum, value)
    end
    sum
  end

  def my_map
    self.my_each_with_index do |value, index|
      self[index] = yield(value)
    end
    self
  end

  def my_none?
    self.my_each do |value| 
      if yield(value)
        return false
      end
    end
    return true
  end

  def my_select
    result = []
    self.my_each do |value|
      if yield(value)
        result << value
      end
    end
    result
  end
end
