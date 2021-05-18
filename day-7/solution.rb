raw_data = File.open('./input.txt').readlines

class Bag

  attr_reader :shade, :color, :contents

  def initialize(shade, color)
    @shade = shade
    @color = color
    @contents = []
  end

  def add_content(bag)
    @contents << bag
  end

  def print(indent = 0)
    puts "#{' ' * 4 * indent}> #{@shade} #{@color}"
    
    @contents.each do |bag|
      bag.print indent+1
    end
  end

  def size
    @contents.size
  end

  def size_full(start = 0)
    
    sum = @contents.sum(0) { |bag| bag.size_full(start)}
    start + sum + contents.size
  end

  def contains(shade, color)
    
  end
end

bags = []

bags_contents = []

raw_data.each do |data|

  data_tokens = data.split(' bags contain')

  bag_name = data_tokens[0]

  contents = data_tokens[1]

  shade = bag_name.split(' ')[0]
  color = bag_name.split(' ')[1]

  bags << Bag.new(shade, color)

  bags_contents << contents
end

bags_contents.each_with_index do |line, index|
  captures = line.scan(/(([\d])\s([\w]+)\s([\w]+))/)

  captures.each do |capture|
    count, shade, color = capture[0].split(' ')

    bag = bags.find { |bag| bag.color == color && bag.shade == shade }

    1.upto(count.to_i) { |x| bags[index].contents << bag }
  end
end

p bags.each { |bag| bag.size_full }