class Book
    attr_accessor :title, :author, :rentals
  
    def initialize(title, author)
      @title = title
      @author = author
      @rentals = []
    end
  
    def add_rental(date, person)
      rental = Rental.new(date, person, self)
      @rentals << rental
      person.add_rental(rental)
    end
  end