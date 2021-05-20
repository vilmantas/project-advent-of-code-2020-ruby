require_relative 'bag_factory'

raw_data = File.open('./input.txt').readlines

class Bag

  attr_reader :shade, :color, :contents

  def initialize(shade, color)
    @shade = shade
    @color = color
    @contents = []
    @contains = {}
    @full_size = nil
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

    unless @full_size.nil?
      puts "Size already calculated for: #{@shade}-#{@color} - #{@full_size}..."
      return start + @full_size + @contents.size
    end

    sum = @contents.sum(0) { |bag| bag.size_full(start)}

    @full_size = sum

    puts "Size calculated (#{sum})"

    start + sum + @contents.size
  end


  def contains(shade, color)

    if @contains.include?("#{shade}-#{color}")
      puts "Content already checked for : #{@shade}-#{@color} - #{@contains["#{shade}-#{color}".to_sym]}..."
      return @contains["#{shade}-#{color}".to_sym]
    end


    result = @contents.find { |bag| bag.color == color && bag.shade == shade } || @contents.any? { |bag| bag.contains(shade, color) }

    # puts "Content checked for : #{@shade}-#{@color} - #{result}..."

    @contains["#{shade}-#{color}".to_sym] = result

    result
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

  bags << BagFactory.for(shade, color)

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





def part_1(bags)
  sum = 0
  bags.each do |bag|
    sum += 1 if bag.contains('shiny', 'gold')
  end
  sum
end

def part_2(bags)
  bag = bags.find { |bag| bag.color == 'gold' && bag.shade == 'shiny'}
  bag.size_full
end
p sum

p 'done'
