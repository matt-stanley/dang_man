require 'json'
require 'date'
require_relative 'dict.rb'

class Game

  def initialize()
    @secret_word = Dict.list[rand(0..Dict.list.length)]
    @indices_revealed = []
    @strikes_remaining = 5
  end

  def save(filename)
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

  def secret_word
    @secret_word
  end

  def indices_revealed
    @indices_revealed
  end

  def strikes_remaining
    @strikes_remaining
  end

end
