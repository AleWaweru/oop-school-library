class Menu
  def self.display_menu
    puts ' '
    puts 'Please select an option (number only)'
    puts '[1] List all books'
    puts '[2] List all people'
    puts '[3] Create a person'
    puts '[4] Create a book'
    puts '[5] Create a rental'
    puts '[6] List all rentals for a given person'
    puts '[7] Exit'
  end

  def self.options
    gets.chomp.to_i
  end
end
