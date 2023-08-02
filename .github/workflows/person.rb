require_relative 'Nameable'
class Person < Nameable

  attr_accessor :name, :age, :rentals
  attr_reader :id, 

  def initialize(name = "Unknown", age = nil, parent_permission = true)
    super(name)
    @id = generate_id
    @age = age
    @parent_permission = parent_permission
    @rentals = []
  end

  def age=(age)
    @age = age
  end

  def can_use_services?
    of_age? || @parent_permission
  end

  def add_rental(date, book)
    Rental.new(date, self, book)
  end

  private

  def of_age?
    @age.to_i >= 18
  end

  def generate_id
    rand(1..1000)
  end
end
