require_relative '../classes/rental'
require_relative '../classes/book'
require_relative '../classes/person'

describe Rental do
  describe '#initialize' do
    it 'creates a rental with a date, book, and person' do
      book = Book.new('Ruby Programming', 'Ruby Guy')
      person = Person.new(25, name: 'Jane')
      rental = Rental.new('2022-07-01', book, person)
      expect(rental.date).to eq('2022-07-01')
      expect(rental.book).to eq(book)
      expect(rental.person).to eq(person)
      expect(book.rentals).to eq([rental])
      expect(person.rentals).to eq([rental])
    end
  end
end
