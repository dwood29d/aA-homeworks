require 'byebug'

class Board
  attr_accessor :cups

  def initialize(name1, name2)
    @cups = Array.new(14) { [] }
    @name1 = name1
    @name2 = name2

    place_stones
  end

  def place_stones
    # helper method to #initialize every non-store cup with four stones each
    cups.each_with_index { |cup, i| 4.times { cup << :stone } unless i == 6 || i == 13 }
  end

  def valid_move?(start_pos)
    # TODO Finish this method
    raise 'Invalid starting cup' unless start_pos.between?(0, 12) && start_pos != 6
    raise 'Starting cup is empty' if cups[start_pos].empty?

    true
  end

  def make_move(start_pos, current_player_name)
    stones = cups[start_pos]
    cups[start_pos] = []
    pos = start_pos
    # debugger
    until stones.count == 0
      pos = (pos + 1) % 14
      if pos == 6
        cups[pos] << stones.pop if current_player_name == @name1
      elsif pos == 13
        cups[pos] << stones.pop if current_player_name == @name2
      else
        cups[pos] << stones.pop
      end
    end

    render
    next_turn(pos)
  end

  def next_turn(ending_cup_idx)
    return :prompt if ending_cup_idx == 6 || ending_cup_idx == 13
    return :switch if cups[ending_cup_idx].count == 1

    ending_cup_idx
  end

  def render
    print "      #{@cups[7..12].reverse.map { |cup| cup.count }}      \n"
    puts "#{@cups[13].count} -------------------------- #{@cups[6].count}"
    print "      #{@cups.take(6).map { |cup| cup.count }}      \n"
    puts ""
    puts ""
  end

  def one_side_empty?
    cups[0..5].all? { |cup| cup.empty? } || cups[7..12].all? { |cup| cup.empty? }
  end

  def winner
    return :draw if cups[6] == cups[13]
    return @name1 if cups[6].count > cups[13].count

    @name2
  end
end
