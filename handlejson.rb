require_relative 'book'
require_relative 'student'
require_relative 'teacher'
require_relative 'rental'
require_relative 'classroom'
require 'json'

module JsonHandler
  def load_from_json(filename, klass)
    return [] unless File.exist?(filename)

    json_data = JSON.parse(File.read(filename))
    if klass.is_a?(Class)
      case klass
      when Book
        json_data.map { |hash| klass.new(hash['title'], hash['author']) }
      when Person
        json_data.map do |hash|
          klass.new(hash['type'], hash['age'], name: hash['name'], parent_permission: hash['parent_permission'])
        end
      when Rental
        json_data.map do |hash|
          book = load_book_from_json(hash['book'])
          person = load_person_from_json(hash['person'])
          klass.new(hash['date'], book, person)
        end
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

  def load_book_from_json(book_hash)
    Book.new(book_hash['title'], book_hash['author'])
  end

  def load_person_from_json(person_hash)
    if person_hash['type'] == 'Student'
      Student.new(Classroom.new('math'), person_hash['age'], name: person_hash['name'],
                                                             parent_permission: person_hash['parent_permission'])
    elsif person_hash['type'] == 'Teacher'
      Teacher.new(
        person_hash['specialization'],
        person_hash['age'],
        name: person_hash['name'],
        parent_permission: person_hash['parent_permission']
      )
    end
  end

  def save_to_json(data, filename)
    existing_data = load_from_json(filename, []) || []
    return if data.nil?

    updated_data = merge_and_map_data(existing_data, data)

    unique_key = unique_key_for_data(data)

    unique_data = generate_unique_data(updated_data, unique_key)

    write_to_json_file(filename, unique_data)
  end

  def merge_and_map_data(existing_data, data)
    existing_data + data.map(&:to_hash)
  end

  def unique_key_for_data(data)
    case data.first
    when Book
      'title'
    when Person
      'id'
    when Rental
      'date'
    end
  end

  def generate_unique_data(data, unique_key)
    if unique_key
      data.uniq { |item| item[unique_key] }
    else
      data
    end
  end

  def write_to_json_file(filename, data)
    File.write(filename, JSON.generate(data))
  end
end
