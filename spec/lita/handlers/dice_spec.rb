require "spec_helper"

describe Lita::Handlers::Dice, lita_handler: true do
  it { routes_command("roll").to(:roll) }
end
