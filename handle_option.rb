class Option
  def self.handle_option(option, app)
    option_commands = {
      1 => ListAllBooksCommand,
      2 => ListAllPeopleCommand,
      3 => CreatePersonCommand,
      4 => CreateBookCommand,
      5 => CreateRentalCommand,
      6 => ListAllRentalsCommand,
      7 => ExitCommand
    }

    command = option_commands[option]
    if command
      command.new(app).execute
    else
      puts 'Enter a number between 1 and 7.'
    end
  end
end

class ListAllBooksCommand
  def initialize(app)
    @app = app
  end

  def execute
    @app.list_all_books
  end
end

class ListAllPeopleCommand
  def initialize(app)
    @app = app
  end

  def execute
    @app.list_all_people
  end
end

class CreatePersonCommand
  def initialize(app)
    @app = app
  end

  def execute
    @app.create_person
  end
end

class CreateBookCommand
  def initialize(app)
    @app = app
  end

  def execute
    @app.create_book
  end
end

class CreateRentalCommand
  def initialize(app)
    @app = app
  end

  def execute
    @app.create_rental
  end
end

class ListAllRentalsCommand
  def initialize(app)
    @app = app
  end

  def execute
    @app.list_all_rentals
  end
end

class ExitCommand
  def initialize(app)
    @app = app
  end

  def execute
    puts 'Exiting'
  end
end
