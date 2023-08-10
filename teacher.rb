require_relative 'person'

class Teacher < Person
  def initialize(specialization, age, name: 'Unknown', parent_permission: true)
    super('Teacher', age, name: name, parent_permission: parent_permission)
    @specialization = specialization
  end

  def can_use_services?
    true
  end

  def to_hash
    {
      'type' => self.class.name,
      'name' => @name,
      'age' => @age,
      'specialization' => @specialization,
      'parent_permission' => @specialization
    }
  end
end
