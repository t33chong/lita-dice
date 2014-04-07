require "lita"

module Lita
  module Handlers
    class Dice < Handler
      route(/^roll\s+(\d+)d(\d+)/i, :rollxdy, command: true, help: {
        'roll XdY' => 'Roll X Y-sided dice'})

      route(/^roll\s+(\d+)$/i, :rollx, command: true, help: {
        'roll X' => 'Roll X 6-sided dice'})

      route(/^roll\s+[^\d]/i, :roll, command: true, help: {
        'roll' => 'Roll one 6-sided die'})

      def rollxdy(response)
        x, y = response.matches.first
        x = x.to_i
        y = y.to_i
        if x > 20 or x < 1
          s = 'You can only roll between 1 and 20 dice.'
        else
          s = response.user.name + ' rolled '
          (1..x).each do |n|
            s += (1..y).to_a.sample.to_s + ' '
          end
        end
        response.reply s
      end

      def rollx(response)
        x = response.matches.first.first.to_i
        if x > 20 or x < 1
          s = 'You can only roll between 1 and 20 dice.'
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
