require_relative 'student'
require_relative 'teacher'
require_relative 'rental'
require_relative 'book'

class App
  attr_reader :books, :people, :rentals

  def initialize
    @books = []
    @people = []
    @rentals = []
  end

  def list_all_books
    return puts 'No books in library' if @books.empty?

    @books.each { |book| puts "Title: #{book.title}, Author: #{book.author}" }
  end

  def list_all_people
    return puts 'No people found.' if @people.empty?

    @people.each { |person| puts "[#{person.class}] Name: #{person.name}, Id: #{person.id}, Age: #{person.age}" }
  end

  def create_person
    print 'Do you want to create a student (1) or a teacher (2)? [Input the number]:'
    input = gets.chomp

    case input
    when '1'
      create_student
    when '2'
      create_teacher
    end
  end

  def create_student
    print 'Age: '
    age = gets.chomp.to_i
    print 'Name: '
    name = gets.chomp
    print 'Has parent permission? [Y/N]: '
    permission = gets.chomp.upcase

    student = Student.new(age, 'classroom', name: name, parent_permission: permission == 'Y')
    @people << student
    puts 'Student created successfully'
  end

  def create_teacher
    print 'Enter name of teacher: '
    name = gets.chomp
    print 'Enter age: '
    age = gets.chomp.to_i
    print 'Enter Specialization: '
    specialization = gets.chomp
    teacher = Teacher.new(age, specialization, name: name)
    @people << teacher
    puts 'Teacher created successfully'
  end

  def create_book
    print 'Title: '
    title = gets.chomp
    print 'Enter the Author name: '
    author = gets.chomp
    book = Book.new(title, author)
    @books << book
    puts 'Book created successfully'
  end

  def create_rental
    puts 'Select a book from the following list by number: '
    @books.each_with_index { |book, index| puts "#{index}) Title: #{book.title}, Author: #{book.author}" }
    book_id = gets.chomp.to_i

    puts 'Select a person from the following list by number'
    @people.each_with_index do |person, index|
      puts "#{index}) [#{person.class}] [#{person.class}] Name: #{person.name}, Id: #{person.id}, Age: #{person.age}"
    end
    person_id = gets.chomp.to_i

    print 'Date: '
    date = gets.chomp

    rental = Rental.new(date, books[book_id], people[person_id])
    @rentals << rental
    puts 'Created a rental.'
  end

  def list_all_rentals
    print 'ID of the person: '
    id = gets.chomp.to_i
    puts 'Rentals: '
    list = []
    @rentals.each do |rental|
      list << "Date: #{rental.date}, Book: '#{rental.book.title}' by #{rental.book.author}" if rental.person.id == id
    end
    return list.each { |rental| puts rental } unless list.empty?

    puts 'No record found for the selected person'
  end
end
