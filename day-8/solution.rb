raw_data = File.open('./input.txt').readlines

def prepare_instructions(raw_data)
  counter = 0

  instructions = {}

  raw_data.each do |line|

    captures = line.scan /([A-z]+)\s([+-][\d]+)/

    instruction = captures[0][0]
    number = captures[0][1]

    instructions[counter] = { instruction: instruction, number: number.to_i}

    counter += 1
  end

  instructions
end

def run_instructions(instructions)
  acc = 0

  current_instruction = 0

  instruction_tracker = []

  while true

    unless instructions.keys.include? current_instruction
      return { current_instruction: -1, acc: acc }
    end

    if instruction_tracker.include?(current_instruction)
      puts "instruction: #{current_instruction}"
      puts "acc: #{acc}"
      return { current_instruction: current_instruction, acc: acc }
    end

    instruction_tracker << current_instruction

    executing_instruction = instructions[current_instruction]

    case executing_instruction[:instruction]
    when 'nop'
      current_instruction += 1
      next
    when 'jmp'
      current_instruction += executing_instruction[:number]
      next
    when 'acc'
      current_instruction += 1
      acc += executing_instruction[:number]
      next
    end
  end
end

def part_one(instructions)

  run_instructions instructions

end

def part_two(instructions)

  result = run_instructions instructions

  previously_changed = -1

  while result[:current_instruction] != -1

    new_instructions = {}

    instructions.each do |intruct|
      new_instructions[intruct[0]] = { instruction: intruct[1][:instruction], number: intruct[1][:number]}
    end

    (previously_changed + 1).upto(new_instructions.size) do |num|

      instruction = new_instructions[num]

      if instruction[:instruction] == 'jmp'
        instruction[:instruction] = 'nop'
        previously_changed = num
        break
      elsif instruction[:instruction] == 'nop'
        instruction[:instruction] = 'jmp'
        previously_changed = num
        break
      end
    end

    result = run_instructions new_instructions

  end

  p result


end


part_two(prepare_instructions(raw_data))