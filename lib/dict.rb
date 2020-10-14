class Dict

  def self.generate_list(file)
    @@list = []
    File.foreach(file) do |line|
      if line.chomp.length >= 4
        @@list.push(line.chomp)
      end
    end
  end

  def self.list
    @@list
  end
end