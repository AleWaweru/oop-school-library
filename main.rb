require_relative 'app'
require_relative 'menu'
require_relative 'handle_option'

def main
  app = App.new
  option = 0
  until option == 7
    Menu.display_menu
    option = Menu.options
    Option.handle_option(option, app)
  end

  until option == 7
    Menu.display_menu
    option = Menu.options
    Option.handle_option(option, app)
  end
end

main
