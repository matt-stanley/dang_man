require_relative 'dict'
require_relative 'game'

class Play
  def self.new_game(list)
    game = Game.new(Dict.random_word(list))

    Play.play_game(game)
  end

  def self.play_game(game)
    game_over = false
    game_won = false
    until game_over || game_won
      Menu.print_header
      Play.print_secret_word(game)
      puts "\n\n"
      Play.print_strikes(game)
      puts "\n"
      Play.print_letters_remaining(game)
      puts "\n\n"
      puts 'Guess a letter!'
      puts '0: Main Menu'
      puts '1: Save Game'

      guess = gets.chomp
      if guess == '1'
        Menu.save_game_menu(game)
      elsif guess == '0'
        Menu.main_menu
      end
      game.make_guess(guess)

      status = game.check_game_status
      if status == 'game over'
        game_over = true
        Play.game_over(game)
      elsif status == 'game won'
        game_won = true
        Play.game_won(game)
      end
    end
  end

  def self.print_secret_word(game)
    puts '~* Secret Word *~'
    puts game.redacted_secret_word
  end

  def self.reveal_secret_word(game)
    puts '~* Secret Word *~'
    puts "\n"
    puts game.reveal_secret_word
  end

  def self.print_strikes(game)
    print 'Strikes: ['

    (5 - game.strikes_remaining).times { print 'X' }

    game.strikes_remaining.times { print ' ' }

    puts ']'
  end

  def self.print_letters_remaining(game)
    puts 'Letters Remaining:'
    game.letters_remaining.each_with_index do |letter, index|
      print ' '
      print letter
      print "\n" if (index % 13).zero? && index > 0
    end
  end

  def self.game_over(game)
    Menu.print_header
    puts 'Dang, Man!'
    puts 'Better luck next time!'
    puts "\n"
    Play.reveal_secret_word(game)
    puts "\n"
    Play.print_strikes(game)
    puts "\n"
    Play.print_letters_remaining(game)
    puts "\n"

    puts 'Press Enter to return to the Main Menu'
    gets

    Menu.main_menu
  end

  def self.game_won(game)
    Menu.print_header
    puts 'GREAT JOB, DUDE!'
    puts 'You win!'
    puts "\n"
    Play.reveal_secret_word(game)
    puts "\n"
    Play.print_strikes(game)
    puts "\n"
    Play.print_letters_remaining(game)
    puts "\n"

    puts 'Press Enter to return to the Main Menu'
    gets

    Menu.main_menu
  end
end
