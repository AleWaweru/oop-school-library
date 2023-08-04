require_relative 'nameable'
require_relative 'book'
require_relative 'rental'

class Person < Nameable
  attr_accessor :name, :age, :rentals
  attr_reader :parent_permission

  def initialize(age, parent_permission: true)
    super()
    @id = generate_id
    @age = age
    @parent_permission = parent_permission
    @rentals = []
  end

  def can_use_services?
    of_age? || @parent_permission
  end

  def add_rental(date, book)
    Rental.new(date, book, self)
  end

  private

  def of_age?
    @age.to_i >= 18
  end

  def generate_id
    rand(1..1000)
  end
end
