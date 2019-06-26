class Simon
  COLORS = %w(red blue green yellow)

  attr_accessor :sequence_length, :game_over, :seq

  def initialize
    @sequence_length = 1
    @game_over = false
    @seq = []
  end

  def play
    until @game_over
      take_turn
      system("clear")
    end

    game_over_message
    reset_game
  end

  def take_turn
    show_sequence
    require_sequence

    unless @game_over
      round_success_message
      @sequence_length += 1
    end
  end

  def show_sequence
    add_random_color
    @seq.each do |color|
      puts color
      sleep 1
      system("clear")
      sleep 0.5
    end
  end

  def require_sequence
    puts "Please repeat the sequence of colors"
    @seq.each do |color|
      input = gets.chomp
      unless color == input
        @game_over = true
        break
      end
    end
    sleep 1
  end

  def add_random_color
    seq << COLORS.sample
  end

  def round_success_message
    puts "Good job! Lets make it a little harder"
  end

  def game_over_message
    puts "You lose"
  end

  def reset_game
    @sequence_length = 1
    @game_over = false
    @seq = []
  end
end
