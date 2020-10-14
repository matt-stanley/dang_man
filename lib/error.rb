class Error

  def self.print_header
    puts '##############'
    puts '#   ERROR!   #'
    puts '##############'
    puts "\n\n"
  end

  def self.broke
    Error.print_header
    puts 'You broke something!'
    puts 'Press any key to restart.'
    gets
    Menu.opening_screen
  end

  def self.corrupted_save
    Error.print_header
    puts 'ERR: Save file corrupted.'
    puts 'Press any key to restart.'
    gets
    Menu.opening_screen
end