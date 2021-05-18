def read_data
  File.open('input.txt').readlines
end

def part_one(data)

  max = 0

  data.each do |line|
    row = resolve_value line[0..6], 'B'
    col = resolve_value line[7..9], 'R'

    seat_id = (row * 8) + col

    puts "#{row}, #{col} =  #{seat_id}"

    max = seat_id if seat_id > max
  end

  puts max
end

def part_two(data)

  seat_ids = []

  data.each do |line|
    row = resolve_value line[0..6], 'B'
    col = resolve_value line[7..9], 'R'

    seat_id = (row * 8) + col

    seat_ids.append seat_id
  end

  (75..864).each do |num|
    puts num unless seat_ids.include? num
  end

  seat_ids

end

# @param [String] code
# @param [String] valid_val
def resolve_value(code, valid_val)
  code.gsub!(/[^#{valid_val}]/, '0')
  code.gsub!(valid_val, '1')
  code.to_i(2)
end


puts resolve_value 'FFFFBBB', 'B'

#part_two read_data