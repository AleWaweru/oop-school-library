require_relative 'person'

class Teacher < Person
  attr_accessor :specialization, :id

  def initialize(age, specialization, **defaults)
    @id = rand(10..100)
    defaults[:name] ||= 'Unknown'
    defaults[:parent_permission] = true if defaults[:parent_permission].nil?
    name = defaults.delete(:name)
    super(age, **defaults)
    @specialization = specialization
    @name = name
  end

  def can_use_services?
    true
  end
end
