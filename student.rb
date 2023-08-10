require_relative 'person'

class Student < Person
  attr_accessor :classroom

  def initialize(classroom, age, name: 'Unknown', parent_permission: true)
    super('Student', age, name: name, parent_permission: parent_permission)
    @classroom = classroom
    classroom&.add_student(self)
  end

  def classroom_label
    classroom&.label
  end

  def play_hooky
    '¯\(ツ)/¯'
  end

  def to_hash
    { 
      'type' => 'Student',
      'name' => @name,
      'age' => @age,
      'parent_permission' => @parent_permission,
      'rentals' => @rentals.map { |rental| { 'date' => rental.date }}
    }
  end
end
