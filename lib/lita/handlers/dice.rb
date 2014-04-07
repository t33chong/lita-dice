require "lita"

module Lita
  module Handlers
    class Dice < Handler
      route(/^roll\s+(\d+)/i, :rollx, command: true, help: {
        'roll X' => 'Roll X dice'})

      route(/^roll\s+[^\d]/i, :roll, command: true, help: {
        'roll' => 'Roll one die'})

      def rollx(response)
        x = response.matches.first.first.to_i
        if x > 20
          s = 'You cannot roll more than 20 dice at a time.'
        else
          s = response.user.name + ' rolled '
          (1..x).each do |n|
            s += (1..6).to_a.sample.to_s + ' '
          end
        end
        response.reply s
      end

      def roll(response)
        s = response.user.name + ' rolled '
        s += (1..6).to_a.sample.to_s
        response.reply s
      end
    end

    Lita.register_handler(Dice)
  end
end
