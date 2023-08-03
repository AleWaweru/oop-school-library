require_relative 'person'

class Student < Person
  attr_reader :classroom, :id

  def initialize(age, classroom, **defaults)
    @id = rand(10..100)
    defaults[:name] ||= 'Unknown'
    defaults[:parent_permission] = true if defaults[:parent_permission].nil?
    name = defaults.delete(:name) # Remove the :name key from defaults
    super(age, **defaults)
    @classroom = classroom
    @name = name # Set the name separately after calling super
  end

  def assign_classroom=(classroom)
    @classroom = classroom
    classroom.students.push(self) unless classroom.students.include?(self)
  end

  def play_hooky
    '¯(ツ)/¯'
  end
end
