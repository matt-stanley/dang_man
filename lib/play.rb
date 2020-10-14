require_relative 'dict'
require_relative 'game'

class Play
  def self.new_game(list)
    secret_word = Dict.random_word(list)
    game = Game.new(secret_word)

    Play.play_game(game)
  end

  def self.play_game(game)
    while game.strikes_remaining > 0



    
end