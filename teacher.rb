require_relative 'person'

class Teacher < Person
    attr_accessor :specialization

    def initialize(name = 'unknown', age, parent_permission: true, specialization)
        super(age, name, parent_permission)
        @specialization = specialization
    end
    def can_use_services?
        true
    end

end