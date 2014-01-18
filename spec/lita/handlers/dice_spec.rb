require "spec_helper"

describe Lita::Handlers::Dice, lita_handler: true do
  it { routes_command("roll").to(:roll) }

  describe "#roll" do
    it "replies with a random number from 1 to 6" do
      send_command "roll"
      expect("1".."6").to include(replies.first)
    end
  end
end
