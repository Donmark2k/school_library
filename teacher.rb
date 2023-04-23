require_relative 'person'

class Teacher < Person
  attr_accessor :specialization

  def initialize(name, age, specialization, parent_permission: true)
    super(name, age, parent_permission: parent_permission)
    @specialization = specialization
  end

  def id=(value)
    @id = value
  end

  def can_use_services?
    true
  end
end
