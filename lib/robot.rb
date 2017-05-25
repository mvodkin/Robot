class RobotError < StandardError
end

class Robot

  attr_reader :grid, :position, :direction

  DIRECTIONS = {
    "NORTH"   =>  [0, 1],
    "SOUTH"   =>  [0, -1],
    "EAST"    =>  [1, 0],
    "WEST"    =>  [-1, 0]
  }

  DIR_NAMES = ["NORTH", "EAST", "SOUTH", "WEST"]

  def initialize#(position = [0, 0], direction = "NORTH")
    @position = nil#position
    @direction = nil#direction
  end

  def report
    print position[0], ",", position[1], ",", direction, "\n"
  end

  def move
    @position = calculate_move
  end

  def turn_right
    DIR_NAMES.rotate!
    @direction = DIR_NAMES[0]
  end

  def turn_left
    DIR_NAMES.rotate!(-1)
    @direction = DIR_NAMES[0]
  end

  def place(x, y, direction)
    new_position = [x.to_i, y.to_i]

    unless valid_position?(new_position) && valid_direction?(direction)
      raise RobotError, "Position is out of bounds"
    end

    @position = new_position
    @direction = direction
    until DIR_NAMES[0] == direction
      DIR_NAMES.rotate!
    end
  end

  private

  def valid_position?(new_position)
    new_position.all? { |coord| coord.between?(0, 5) }
  end

  def valid_direction?(direction)
    DIR_NAMES.include?(direction)
  end

  def calculate_move
    new_position = [
      position[0] + DIRECTIONS[direction][0],
      position[1] + DIRECTIONS[direction][1]
    ]

    valid_position?(new_position) ? new_position : position
  end

end

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

  #SW    W    NW
  # X X X X X
  # X X X X X
#S  X X X X X  N
  # X X X X X
  # X X X X X
  #SE    E    NE
