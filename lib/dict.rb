# Handles word dictionaries and 
class Dict
  # attr_reader :list

  # def initialize(filename)
  #   @list = []
  #   File.foreach(filename) do |line|
  #     @list.push(line.chomp) if line.chomp.length >= 3;
  #   end
  # end

  def self.random_word(list)
    list[rand(0..Dict.list.length)]
  end

  def self.available_lists
    Dir.glob('/dict/*.txt')
  end
end
