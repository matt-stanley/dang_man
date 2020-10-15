# Handles errors and redirects accordingly
class Error
  def self.print_header
    system('clear') || system('cls')
    puts '##############'
    puts '#   ERROR!   #'
    puts '##############'
    puts "\n\n"
  end

  def self.broke
    Error.print_header
    puts 'You broke something!'
    puts 'Press Enter to restart.'
    gets
    Menu.main_menu
  end

  def self.corrupted_save
    Error.print_header
    puts 'ERR: Save file corrupted.'
    puts 'Press Enter to restart.'
    gets
    Menu.main_menu
  end

  def self.hax
    Error.print_header
    puts 'ERR: Nice try, hackers!'
    puts 'Press Enter to restart.'
    gets
    Menu.main_menu
  end
end
