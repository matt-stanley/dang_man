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

  def self.main_menu
    $prev_screen = 'main_menu' # Keeps track of where the user came from, to 
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
      Menu.load_game_menu
    else
      Error.wrong_choice
    end
  end

  def self.choose_list
    Menu.print_header
    puts "Choose a the word list you want to use by typing its ID, or 0 to return to the main menu:\n"

    dict_list = Dict.available_lists

    choice_num = 1
    dict_list.each do |filename|
      display_name = filename.gsub(/\.[0-9a-z]+$/, '')  # Shows filename without extension
      puts "#{choice_num}. #{display_name}\n"
      choice_num += 1
    end

    choice = gets.chomp

    if choice == '0'
      Menu.main_menu
    elsif dict_list[choice - 1]
      list = dict_list[choice - 1]
      Play.new_game(list)
    else
      Error.wrong_choice
    end
  end


  def self.load_game_menu
    Menu.print_header
    puts "Choose a saved game by typing its ID, or 0 to return to the main menu:\n"

    saved_games = Game.read_saves

    choice_num = 1
    saved_games.each do |filename|
      display_name = filename.gsub(/\.[0-9a-z]+$/, '')  # Shows filename without extension
      puts "#{choice_num}. #{display_name}\n"
      choice_num += 1
    end

    choice = gets.chomp

    if choice == '0'
      Menu.main_menu
    elsif saved_games[choice - 1]
      game = Game.load_game(saved_games[choice - 1])
      Play.start_game(game)
    else
      Error.wrong_choice
    end
  end
end
