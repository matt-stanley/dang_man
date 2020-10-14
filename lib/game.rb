require 'json'
require 'date'
require_relative 'dict'

# Handles game state: saving, loading, reading saves, and creating new games.
class Game
  attr_reader :secret_word, :indices_revealed, :strikes_remaining

  def initialize(secret_word, indices_revealed = [], strikes_remaining = 5)
    @secret_word = secret_word
    @indices_revealed = indices_revealed
    @strikes_remaining = strikes_remaining
  end

  def save_game(filename)
    time = DateTime.now
    timestamp = time.strftime('%m/%d/%Y %H:%M:%S')

    save_state = {
      'name' => filename,
      'timestamp' => timestamp,
      'secret_word' => @secret_word,
      'indices_revealed' => @indices_revealed,
      'strikes_remaining' => @strikes_remaining
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
      save_state['strikes_remaining']
    )

    Play.play_game(game)
  end

  # Returns array of saved games, sorted by date modified, newest first
  def self.read_saves
    Dir.glob('/saves/*.json').sort_by do |a, b|
      File.mtime(b) <=> file.mtime(a)
    end
  end

end
