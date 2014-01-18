require "lita"

module Lita
  module Handlers
    class Dice < Handler
      route %r{roll}i, :roll, command: true, help: {'roll' => 'Roll one die'}

      def roll(response)
        response.reply (1..6).to_a.sample.to_s
      end
    end

    Lita.register_handler(Dice)
  end
end
