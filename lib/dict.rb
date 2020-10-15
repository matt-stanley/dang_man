# Handles word dictionaries and 
class Dict
  # attr_reader :list

  # def initialize(filename)
  #   @list = []
  #   File.foreach(filename) do |line|
  #     @list.push(line.chomp) if line.chomp.length >= 3;
  #   end
  # end

  def self.random_word(file)
    list = []
    File.foreach("dict/#{file}") do |line|
      list.push(line.chomp.upcase) if line.chomp.length >= 3;
    end
    list[rand(0..list.length)]
  end

  def self.available_lists
    Dir.glob('dict/*.txt').map do |file|
      File.basename(file)
    end
  end
end