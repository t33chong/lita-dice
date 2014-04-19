require "lita"

module Lita
  module Handlers
    class Dice < Handler
      route(/^roll(\s+(?<x>\d+)?d?(?<y>\d+)?)?/i, :roll, command: true, help: {
        'roll' => 'Roll one 6-sided die.',
        'roll X' => 'Roll X 6-sided dice.',
        'roll XdY' => 'Roll X Y-sided dice.'})

      def roll(response)
        int = lambda do |n, default|
          if n == nil
            return default
          end
          n.to_i
        end

        x, y = response.matches.first
        x = int.call(x, 1)
        y = int.call(y, 6)

        if x > 20 or x < 1
          s = 'You can only roll between 1 and 20 dice.'
        elsif y > 1000 or y < 2
          s = 'Dice must have between 2 and 1000 sides.'
        else
          rolls = []
          (1..x).each do |n|
            rolls << (1..y).to_a.sample
          end
          s = "#{response.user.name} rolled #{rolls.join(' ')}"
          if x > 1
            total = rolls.inject(:+)
            s += " (#{total})"
          end
        end
        response.reply s
      end
    end

    Lita.register_handler(Dice)
  end
end
