require_relative 'classes/book_lister'
require_relative 'classes/person_lister'
require_relative 'classes/person_creator'
require_relative 'classes/book_creator'
require_relative 'classes/rental_creator'
require_relative 'classes/rental_lister'
require_relative 'classes/utility/menu'
require_relative 'classes/utility/io'
require_relative 'classes/read_data/load_book'
require_relative 'classes/read_data/load_people'
require_relative 'classes/read_data/load_rentals'
require 'json'

class App
  BOOKS_FILE = './data/books.json'.freeze
  PEOPLE_FILE = './data/people.json'.freeze
  RENTALS_FILE = './data/rentals.json'.freeze

  def initialize
    @books = read_books(BOOKS_FILE) || []
    @people = read_people(PEOPLE_FILE) || []
    @rentals = read_rentals(RENTALS_FILE) || []
    @book_lister = BookLister.new(@books)
    @person_lister = PersonLister.new(@people)
    @person_creator = PersonCreator.new(@people)
    @book_creator = BookCreator.new(@books)
    @rental_creator = RentalCreator.new(@books, @people, @rentals)
    @rental_lister = RentalLister.new(@rentals)
    @menu = Menu.new
    @io = IO.new(
      book_lister: BookLister.new(@books),
      person_lister: PersonLister.new(@people),
      person_creator: PersonCreator.new(@people),
      book_creator: BookCreator.new(@books),
      rental_creator: RentalCreator.new(@books, @people, @rentals),
      rental_lister: RentalLister.new(@rentals)
    )
  end

  def start
    loop do
      @menu.print
      choice = gets.chomp.downcase
      break unless @io.handle_choice(choice)

      puts "\n"
    end
    save_data
  end

  private

  def save_data
    save_json(@books, BOOKS_FILE)
    save_json(@people, PEOPLE_FILE)
    save_json(@rentals, RENTALS_FILE)
  end

#  add the code here-----------

# 
end
