# spec/person_spec.rb
require 'date'
require_relative '../classes/person'
require_relative '../classes/book'


describe Person do
  subject(:person) { described_class.new(25, name: 'Alice', parent_permission: true) }

  describe '#can_use_services?' do
    it 'returns true if person is of age' do
      allow(person).to receive(:of_age?).and_return(true)
      expect(person.can_use_services?).to be(true)
    end

    it 'returns true if person has parent permission' do
      allow(person).to receive(:of_age?).and_return(false)
      expect(person.can_use_services?).to be(true)
    end

    it 'returns false if person is under 18 and has no parent permission' do
      person = described_class.new(16, parent_permission: false)
      allow(person).to receive(:of_age?).and_return(false)
      expect(person.can_use_services?).to be(false)
    end
  end

  describe '#correct_name' do
    it 'returns the person\'s name' do
      expect(person.correct_name).to eq('Alice')
    end
  end

  describe '#add_rental' do
    it 'creates a new Rental and associates it with the person' do
      book = instance_double('Book', rentals: []) # Create a test double for Book with an empty rentals array
      date = Date.new(2023, 8, 10)

      new_rental = person.add_rental(date, book)

      expect(new_rental).to be_a(Rental)
      expect(person.rentals).to include(new_rental)
      expect(new_rental.person).to eq(person)
      expect(book.rentals).to include(new_rental) # Verify the rental association with the book
    end
  end
end
