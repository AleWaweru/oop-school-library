class Person
    attr_accessor :name, :age 
    attr_reader :id 
    def initialize (name = "Unknown", age =nil, parent_permission = true)
        @id = generate_id
        @age = age
        @name = name
        @parent_permission = parent_permission
    end

    def age =(age)
        @age = age
    end 

    def name =(name)
        @name = name
    end 

    def can_use_services?
        of_age? || @parent_permission
    end

    private

    def of_age?
        @age.to_i >= 18
    end

    def generate_id 
        rand(1..1000)
    end

end


