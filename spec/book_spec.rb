require 'date'
require_relative '../classes/book'
require_relative '../classes/rental' # You might need to require Rental if it's not already required in your code

describe Book do
  subject(:book) { described_class.new('Sample Title', 'Sample Author') }

  describe '#initialize' do
    it 'sets title and author' do
      expect(book.title).to eq('Sample Title')
      expect(book.author).to eq('Sample Author')
    end

    it 'initializes rentals as an empty array' do
      expect(book.rentals).to be_empty
    end
  end

  describe '#to_h' do
    it 'returns book data as a hash' do
      expected_hash = {
        title: 'Sample Title',
        author: 'Sample Author'
      }
      expect(book.to_h).to eq(expected_hash)
    end
  end
end
