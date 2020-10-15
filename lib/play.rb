require_relative 'dict'
require_relative 'game'

class Play
  def self.new_game(list)
    secret_word = Dict.random_word(list)
    game = Game.new(secret_word)

    Play.play_game(game)
  end

  def self.play_game(game, filename = nil)
    game_over = false
    game_won = false
    until game_over || game_won
      Menu.print_header
      Play.print_secret_word
      puts "\n"
      Play.print_strikes
      puts "\n"
      Play.print_letters_remaining
      puts "\n"
      puts 'Guess a letter!'
      puts '0: Main Menu'
      puts '1: Save Game'

      guess = gets.chomp
      game.make_guess(guess)

      status = game.check_game_status
      case status
      when 'game over'
        game_over = true
        Play.game_over
      when 'game won'
        game_won = true
        Play.game_won
      end
    end
  end

  def self.print_secret_word
    puts '~* Secret Word *~'
    puts game.redacted_secret_word
  end

  def self.reveal_secret_word
    puts 'The Secret Word was'
    puts game.reveal_secret_word
  end

  def self.print_strikes
    print 'Strikes: ['

    (5 - game.strikes_remaining).times { print 'X' }

    game.strikes_remaining.times { print ' ' }

    puts ']'
  end

  def self.print_letters_remaining
    puts 'Letters Remaining:'
    game.letters_remaining.each do |letter, index|
      print letter
      print "\n" if (index % 13).zero?
    end
  end

  def game_over
    Menu.print_header
    puts 'Dang, Man!'
    puts 'Better luck next time!'
    Play.reveal_secret_word
    puts "\n"
    Play.print_strikes
    puts "\n"
    Play.print_letters_remaining
    puts "\n"

    puts "Press any key to return to the Main Menu"
    gets

    Menu.main_menu
  end

  def game_won
    Menu.print_header
    puts 'Great job, dude!'
    puts 'You win!'
    Play.reveal_secret_word
    puts "\n"
    Play.print_strikes
    puts "\n"
    Play.print_letters_remaining
    puts "\n"

    puts "Press any key to return to the Main Menu"
    gets

    Menu.main_menu
  end
    
end
