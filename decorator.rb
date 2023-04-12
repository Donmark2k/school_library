require_relative 'nameable'

class Decorator < Nameable
  attr_accessor :nameable

  def initialize(nameable)
    super()
    @nameable = nameable
  end

  def correct_name
    @nameable.correct_name
  end
end

# TrimmerDecorator class
class TrimmerDecorator < Decorator
  def correct_name
    name = nameable.correct_name
    name.length > 10 ? name[0, 10] : name
  end
end

# Capitalize Decorator Class
class CapitalizeDecorator < Decorator
  def correct_name
    nameable.correct_name.capitalize
  end
end
