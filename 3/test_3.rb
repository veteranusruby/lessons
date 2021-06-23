require_relative 'm'

class Foo

  include M

  attr :parameter

  def initialize(value)
    @parameter = value
  end

  def increment
    @parameter += 1
    p @parameter
    p self.class
    self.class.decrement(@parameter)
  end

  def self.decrement(value)
    value -= 1
    p value
  end
end

a = Foo.new(1)
a.increment
a.print
