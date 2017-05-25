require_relative "lib/robot"

def parse_input(input)
  robot = Robot.new()
  placed = false
  commands = input.is_a?(String) ? input.split : input
  i = 0

  while i < commands.length
    case commands[i]
    when "PLACE"
      i += 1
      position = commands[i].split(",")
      robot.place(*position)
      placed = true
    when "MOVE"
      robot.move if placed
    when "LEFT"
      robot.turn_left if placed
    when "RIGHT"
      robot.turn_right if placed
    when "REPORT"
      robot.report if placed
    end
    i += 1
  end
end

if __FILE__ == $PROGRAM_NAME
  parse_input(ARGV)
end
