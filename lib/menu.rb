require_relative 'game'
require_relative 'play'
require_relative 'error'

class Menu
  def self.print_header
    system('clear') || system('cls')
    puts '##############'
    puts '# DANG, MAN! #'
    puts '#  The Game  #'
    puts '##############'
    puts "\n\n"
  end

  def self.opening_screen
    Menu.print_header
    puts 'Welcome!'
    puts "Choose an option by typing a number:\n"
    puts '1. Start a new game'
    puts "2. Load a saved game\n"
    option = gets.chomp

    case option
    when '1'
      Play.start_game(nil)
    when '2'
      Menu.saved_games_screen
    else
      Error.wrong_choice
    end
  end

  def self.load_game_screen
    Menu.print_header
    saved_games = Play.read_saves

    puts "Choose a saved game by typing a number:\n"

    choice_num = 1
    saved_games.each do |filename|
      display_name = filename.gsub(/\.[0-9a-z]+$/, '')  # Shows filename without extension
      puts "#{choice_num}. #{display_name}"
      choice_num += 1
    end

    choice = gets.chomp

    if saved_games[choice - 1]
      game = Game.load_game(saved_games[choice - 1])
      Play.start_game(game)
    else
      Error.wrong_choice
    end
  end

  def self.read_saves
    Dir.glob('/saves/*.json').sort_by do |a, b|
      File.mtime(b) <=> file.mtime(a)
    end
  end
end