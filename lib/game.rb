require 'json'
require 'date'
require_relative 'dict'

# Handles game state: saving, loading, reading saves, and creating new games.
class Game
  attr_reader :indices_revealed, :strikes_remaining, :letters_remaining

  def initialize(secret_word, indices_revealed = [],
                 strikes_remaining = 5,
                 letters_remaining = ('A'..'Z').to_a)
    @secret_word = secret_word
    @indices_revealed = indices_revealed
    @strikes_remaining = strikes_remaining
    @letters_remaining = letters_remaining

    @secret_word.split('').each_with_index do |letter, index|
      @indices_revealed.push(index) if letter == ' ';
    end
  end

  def redacted_secret_word
    secret_word_array = @secret_word.split('')

    secret_word_array.each do |letter, index|
      if @indices_revealed.include?(index)
        print letter.upcase
      else
        print '_'
      end
    end

    secret_word_array.join
  end

  def make_guess(guess)
    guess = guess.upcase
    guess_found = false
    secret_word_array = @secret_word.split('')

    secret_word_array.each_with_index do |letter, index|
      if letter == guess && !indices_revealed.include?(index)
        @indices_revealed.push(index)
        guess_found = true
      end
    end

    @strikes_remaining -= 1 unless guess_found;

    @letters_remaining.gsub!(guess, '_')
  end

  def check_game_status
    if @strikes_remaining.zero?
      'game over'
    elsif @indices_revealed.length == @secret_word.length
      'game won'
    end
  end

  def reveal_secret_word
    if @strikes_remaining.zero? || @indices_revealed.length == @secret_word.length
      @secret_word
    else
      Error.hax
    end
  end

  def save_game(filename)
    time = DateTime.now
    timestamp = time.strftime('%m/%d/%Y %H:%M:%S')

    save_state = {
      'name' => filename,
      'timestamp' => timestamp,
      'secret_word' => @secret_word,
      'indices_revealed' => @indices_revealed,
      'strikes_remaining' => @strikes_remaining,
      'letters_remaining' => @letters_remaining
    }

    File.open("saves/#{filename}.json", 'w') do |file|
      file.write(JSON.generate(save_state))
    end
  end

  def self.load_game(filename)
    save_state = JSON.parse("/saves/#{filename}")

    game = Game.new(
      save_state['secret_word'],
      save_state['indices_revealed'],
      save_state['strikes_remaining'],
      save_state['letters_remaining']
    )

    Play.play_game(game, filename)
  end

  # Returns array of saved games, sorted by date modified, newest first
  def self.read_saves
    Dir.glob('/saves/*.json').sort_by do |a, b|
      File.mtime(b) <=> file.mtime(a)
    end
  end

end
