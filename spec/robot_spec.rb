require "rspec"
require "robot"

describe "Robot" do
  subject(:robot) do
    Robot.new()
  end

  describe "#place" do
    it "Places the robot at the correct position" do
      robot.place(2, 2, "NORTH")
      expect(robot.position).to eq([2, 2])
      expect(robot.direction).to eq("NORTH")
    end

    it "Throws an error with a position input that is out of bounds" do
      expect { robot.place(0, 6, "SOUTH") }.to raise_error(RobotError)
      expect { robot.place(-2, 4, "SOUTH") }.to raise_error(RobotError)
      expect { robot.place(0, 6000, "SOUTH") }.to raise_error(RobotError)
    end

    it "Throws an error with an invalid direction" do
      expect { robot.place(2, 2, "BANANA") }.to raise_error(RobotError)
    end
  end

  describe "#turn_right" do
    it "Correctly turns to the right" do
      robot.place(2, 2, "NORTH")
      robot.turn_right
      expect(robot.direction).to eq("EAST")
      robot.turn_right
      expect(robot.direction).to eq("SOUTH")
    end
  end

  describe "#turn_left" do
    it "Correctly turns to the left" do
      robot.place(2, 2, "SOUTH")
      robot.turn_left
      expect(robot.direction).to eq("EAST")
      robot.turn_left
      expect(robot.direction).to eq("NORTH")
      robot.turn_left
      expect(robot.direction).to eq("WEST")
      robot.turn_left
      expect(robot.direction).to eq("SOUTH")
    end
  end

  describe "#report" do
    it "Prints position and direction to the console" do
      robot.place(2, 2, "SOUTH")
      expect { robot.report }.to output("2,2,SOUTH\n").to_stdout
    end
  end

  describe "parse_input" do
    it "Takes in a string input and calls the appropriate methods" do
      expect { parse_input("PLACE 0,0,NORTH MOVE REPORT") }.to output("0,1,NORTH\n").to_stdout
      expect { parse_input("PLACE 0,0,NORTH LEFT REPORT") }.to output("0,0,WEST\n").to_stdout
      expect { parse_input("PLACE 1,2,EAST MOVE MOVE LEFT MOVE REPORT") }.to output("3,3,NORTH\n").to_stdout
    end
  end

end
