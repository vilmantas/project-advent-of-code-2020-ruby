def read_data
  File.open('./input.txt').readlines
end

# @param [Array] data
def gather_groups(data)

  groups = []
  current_group = []

  data.each do |line|
    if line.strip!.empty?
      groups.append current_group
      current_group = []
    else
      current_group.append line
    end
  end

  groups.append current_group

  groups
end

# @param [Array] group
def gather_answers(group)
  group.map { |answers| answers.split '' }.flatten
end

# @param [Array] groups
def part_one(groups)
  groups.sum(0) { |group| gather_answers(group).uniq.length }
end

def part_two(groups)
  groups.sum(0) do |group|
    first_person = group[0]
    invalid_answers = []
    first_person.split('').each do |init_answer|
      group[1..].each do |answer|
        invalid_answers.append init_answer unless answer.include? init_answer
      end
    end

    result = first_person.size - invalid_answers.uniq.size
    puts result
    result
  end
end

puts part_two(gather_groups(read_data))
