require_relative 'Nameable'
require_relative 'BaseDecorator'


class Person < Nameable
    attr_accessor :name, :age
    attr_reader :id
  
    def initialize(name = "Unknown", age = nil, parent_permission = true)
      @id = generate_id
      @age = age
      @name = name
      @parent_permission = parent_permission
    end
  
    def age=(age)
      @age = age
    end
  
    def name=(name)
      @name = name
    end
  
    def can_use_services?
      of_age? || @parent_permission
    end
  
    def correct_name
      @name
    end
  
    private
  
    def of_age?
      @age.to_i >= 18
    end
  
    def generate_id
      rand(1..1000)
    end
  end
  

person = Person.new('Maximilianus', 22)
person.correct_name
capitalized_person = CapitalizeDecorator.new(person)
puts capitalized_person.correct_name
capitalized_trimmed_person = TrimmerDecorator.new(capitalized_person)
puts capitalized_trimmed_person.correct_name