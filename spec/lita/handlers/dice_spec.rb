require "spec_helper"

describe Lita::Handlers::Dice, lita_handler: true do
  it { routes_command("roll").to(:roll) }

  describe "#roll" do
    it "handles roll as roll 1d6" do
      send_command "roll"
      re = /#{user.name} rolled (\d+)/
      expect(replies.first).to match(re)
      capt = re.match(replies.first).captures
      value = capt.first.to_i
      expect(1..6).to include(value)
    end

    it "handles roll X as roll Xd6" do
      send_command "roll 3"
      re = /#{user.name} rolled (\d+) (\d+) (\d+) \((\d+)\)/
      expect(replies.first).to match(re)
      capt = re.match(replies.first).captures
      a, b, c, total = capt.map { |n| n.to_i }
      expect(1..6).to include(a)
      expect(1..6).to include(b)
      expect(1..6).to include(c)
      expect(a + b + c).to equal(total)
    end

    it "handles roll dY as roll 1dY" do
      send_command "roll d20"
      re = /#{user.name} rolled (\d+)/
      expect(replies.first).to match(re)
      capt = re.match(replies.first).captures
      value = capt.first.to_i
      expect(1..20).to include(value)
    end
  end
end
