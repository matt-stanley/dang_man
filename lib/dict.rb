class Dict

  def initialize(filename)
    @list = []
    File.foreach("#{filename}") do |line|
      if line.chomp.length >= 4
        @list.push(line.chomp)
      end
    end
  end

  def self.available_lists
    Dir.glob('/dict/*.txt')
  end

  def list
    @list
  end
end
