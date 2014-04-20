require "spec_helper"

describe Lita::Handlers::Dice, lita_handler: true do
  it { routes_command("roll").to(:roll) }

  describe "#roll" do
    it "replies with a random number from 1 to 6" do
      send_command "roll"
      expect("1".."6").to include(replies.first)
    end

    it "replies with as many random numbers from 1 to 6 as specified" do
      send_command "roll 3"
      re = /rolled ([1-6]) ([1-6]) ([1-6]) \((\d+)\)/
      expect(replies.first).to match(re)
      capt = re.match(replies.first).captures
      a, b, c, total = capt.map { |n| n.to_i }
      expect(a + b + c).to equal(total)
    end
  end
end
