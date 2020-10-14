require_relative 'game.rb'
require_relative 'dict.rb'

Dict.generate_list('dict/english_words_basic.txt')
game = Game.new()

puts game.secret_word

game.save("test")