require_relative 'book'
require_relative 'Student'
require_relative 'teacher'
require_relative 'rental'
require_relative 'classroom'
require 'json'

class App
  def initialize
    load_data
    @books = []
    @people = []
    @rentals = []
    
  end
  # +++++++++++++++++++++++++++++++++++++++++++
  def save_data
    save_to_json(@books, 'storage/books.json')
    save_to_json(@people, 'storage/people.json')
    save_to_json(@rentals, 'storage/rentals.json')
  end

  def load_data
    @books = load_from_json('storage/books.json', Book)
    @people = load_from_json('storage/people.json', Person)
    @rentals = load_from_json('storage/rentals.json', Rental)
  end
  # ++++++++++++++++++++++++++++++++++++++++++
  def list_all_books
    puts(@books.map { |book| "Title: \"#{book.title}\", Author: #{book.author}" })
  end

  def list_all_people
    puts(@people.map { |person| "[#{person.type}] Name: #{person.name}, ID: #{person.id} Age: #{person.age}" })
  end

  def create_a_person(choice, name, age)
    if choice == '1'
      person = create_a_student(name, age)
      person.type = 'Student'
    elsif choice == '2'
      person = create_a_teacher(name, age)
      person.type = 'Teacher'
    else
      puts 'wrong choice die'
      return
    end
    @people << person
    puts 'Person created successfully'
  end

  def create_a_book(title, author)
    book = Book.new(title, author)
    @books << book
    puts 'Book created successfully'
  end

  def create_a_rental()
    puts 'Select a book from the following list by number'
    list_books
    index_book = gets.chomp.to_i
    puts 'Select a person from following list by number (not id)'
    list_people
    index_person = gets.chomp.to_i
    print 'Date: '
    date = gets.chomp
    rental = Rental.new(date, @books[index_book], @people[index_person])
    @rentals << rental
    puts 'Rental created successfully'
  end

  def list_all_rentals_for_a_given_person_id
    puts 'ID of person: '
    id = gets.chomp.to_i
    puts 'Rentals: '
    @rentals.each do |rental|
      puts "Date: #{rental.date}, Book \"#{rental.book.title}\" by #{rental.book.author}" if rental.person.id == id
    end
  end

  private

  def create_a_student(name, age)
    print 'Has parent permission? [Y/N]: '
    parent = gets.chomp
    permission = %w[Y y].include?(parent)
    label = 'math'
    classroom = Classroom.new(label)
    student = Student.new(classroom, age, name: name, parent_permission: permission)
    classroom.add_student(student)
    student
  end

  def create_a_teacher(name, age)
    print 'Specialization: '
    specialization = gets.chomp
    Teacher.new(specialization, age, name: name)
  end

  def list_books
    @books.each_with_index do |book, index|
      puts "#{index}) Title \"#{book.title}\", Author: #{book.author}"
    end
  end

  def list_people
    @people.each_with_index do |person, index|
      puts "#{index}) [#{person.type}] Name: #{person.name} ID: #{person.id}, Age: #{person.age}"
    end
  end

  # ===========================================
  private

  def save_to_json(data, filename)
    existing_data = load_from_json(filename, []) || []
  
    if data.nil?
      puts ""
      return
    end
  
    updated_data = existing_data + data.map(&:to_hash)
  
    unique_key = case data.first
                 when Book
                   'title'
                 when Person
                   'id'
                 when Rental
                   'date'
                 else
                   nil
                 end
  
    if unique_key
      unique_data = updated_data.uniq { |item| item[unique_key] }
    else
      unique_data = updated_data
    end
  
    File.open(filename, 'w') do |file|
      file.write(JSON.generate(unique_data))
    end
  end
  
  # def load_from_json(filename, klass)
  #   begin
  #     return [] unless File.exist?(filename)
  #     json_data = JSON.parse(File.read(filename))
  #     if klass.is_a?(Class)
  #       if klass == Book
  #         json_data.map { |hash| klass.new(hash['title'], hash['author']) }
  #       elsif klass == Person
  #         json_data.map { |hash| klass.new(hash['type'], hash['age'], name: hash['name'], parent_permission: hash['parent_permission']) }
  #       end
  #     else
  #       json_data
  #     end
  #   rescue JSON::ParserError => e
  #     puts "Error parsing JSON in #{filename}: #{e.message}"
  #     []
  #   end
  # end

  # Update the load_from_json method to accept both filename and klass
def load_from_json(filename, klass)
  begin
    return [] unless File.exist?(filename)

    json_data = JSON.parse(File.read(filename))
    if klass.is_a?(Class)
      if klass == Book
        json_data.map { |hash| klass.new(hash['title'], hash['author']) }
      elsif klass == Person
        json_data.map { |hash| klass.new(hash['type'], hash['age'], name: hash['name'], parent_permission: hash['parent_permission']) }
      else
        json_data.map { |hash| klass.new(**hash) }
      end
    else
      json_data
    end
  rescue JSON::ParserError => e
    puts "Error parsing JSON in #{filename}: #{e.message}"
    []
  end
end

# Update the load_data method to pass the correct arguments
  # def load_from_json(filename, klass)
  #   begin
  #     return [] unless File.exist?(filename)

  #     json_data = JSON.parse(File.read(filename))
  #     if klass.is_a?(Class)
  #       if klass == Book
  #         json_data.map { |hash| klass.new(hash['title'], hash['author']) }
  #       elsif klass == Person
  #         json_data.map { |hash| klass.new(hash['type'], hash['age'], name: hash['name'], parent_permission: hash['parent_permission']) }
  #       else
  #         json_data.map { |hash| klass.new(**hash) }
  #       end
  #     else
  #       json_data
  #     end
  #   rescue JSON::ParserError => e
  #     puts "Error parsing JSON in #{filename}: #{e.message}"
  #     []
  #   end
  # end

  

  # =======================
end
