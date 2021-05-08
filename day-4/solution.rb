def read_data
  File.open('./input.txt').readlines
end

def part_1(data)

  counter = 0

  people = extract_people data

  people.each do |person|
    if validate_person_part_1 person
      counter += 1
      puts person
    end
  end

  counter
end

def part_2(data)

  counter = 0

  people = extract_people data

  people.each do |person|
    if validate_person_part_2 person
      counter += 1
      puts person
    end
  end

  counter
end

def extract_people(data)
  result = []
  person_data = {}
  data.each do |line|
    if line.strip!.empty?
      result.append person_data
      person_data = {}
    else
      person_data = parse_data_line line, person_data
    end
  end
  result.append person_data
  result
end

# @param [String] line
def parse_data_line(line, data)

  data = {} if data.nil?

  parts = line.split

  parts.each do |part|
    values = part.split ':'
    data[values[0]] = values[1]
  end

  data
end

def validate_person_part_1(person)

  keys = person.keys

  return false unless keys.length == 8 || (keys.length == 7 && !keys.include?('cid'))
end

def validate_person_part_2(person)

  return false if validate_person_part_1(person)

  person.all? { |key, value| validate_property(key, value) }
end

def validate_property(key, value)
  valid_eye_colors = %w[amb blu brn gry grn hzl oth]

  return valid_eye_colors.include? value if key == 'ecl'

  if key == 'byr'
    parsed_yr = value.to_i
    return parsed_yr >= 1920 && parsed_yr <= 2002
  end

  if key == 'iyr'
    parsed_yr = value.to_i
    return parsed_yr >= 2010 && parsed_yr <= 2020
  end

  if key == 'eyr'
    parsed_yr = value.to_i
    return parsed_yr >= 2020 && parsed_yr <= 2030
  end

  if key == 'hgt'
    match = value.match /([0-9]+)([a-z]+)/

    if match

      height = match.captures[0].to_i

      if match.captures[1] == 'in'
        return height >= 59 && height <= 76
      else
        return height >= 150 && height <= 193
      end
    end
  end

  if key == 'hcl'
    if value.match /#[a-f0-9]{6}/
      return true
    else
      return false
    end
  end

  if key == 'pid'
    if value.match /[0-9]{9}/
      return true
    else
      return false
    end
  end

  if key == 'cid'
    return true
  end
end

puts part_1 read_data