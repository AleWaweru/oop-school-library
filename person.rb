require_relative 'nameable'

class Person < Nameable
  def initialize(type, age, name: 'Unknown', parent_permission: true)
    super()
    @id = Random.rand(1..200)
    @name = name
    @age = age
    @parent_permission = parent_permission
    @rentals = []
    @type = type
  end

  attr_accessor :name, :age, :type
  attr_reader :id, :rentals

  def add_rental(rental)
    @rentals << rental
    rental.person = self
  end

  def correct_name
    @name
  end

  def can_use_services?
    of_age? || @parent_permission
  end

  def to_hash
    { 
      'type' => @type,
      'name' => @name,
      'age' => @age,
      'parent_permission' => @parent_permission,
      'rentals' => @rentals.map { |rental| { 'date' => rental.date }}
    }
  end

  private

  def of_age?
    @age >= 18
  end
end
