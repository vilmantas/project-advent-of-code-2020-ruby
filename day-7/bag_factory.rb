class BagFactory

  @@bags = {}

  def self.bag_count
    @@bags.keys.size
  end

  def self.for(shade, color)

    return @@bags["#{shade}-#{color}".to_sym] if @@bags.include?("#{shade}-#{color}")

    bag = Bag.new(shade, color)

    @@bags["#{shade}-#{color}".to_sym] = bag

    bag
  end

end