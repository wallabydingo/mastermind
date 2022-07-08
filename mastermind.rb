class Mastermind
  attr_accessor :code_pegs

  @@code_pegs = {1=>'R',2=>'G',3=>'B',4=>'C',5=>'M',6=>'Y'}

  def initialize
    #attr_accessor :code

    @code = Array.new(4)
    @guess_number = 0
    @guesses = Array.new(12) {Array.new(4)}
    @feedback = Array.new(12) {Array.new(4)}
  end

  def code
    @code
  end

  def show_code
    puts "╔═══╦═══╦═══╦═══╗"
    puts "║ #{self.code[0]} ║ #{self.code[1]} ║ #{self.code[2]} ║ #{self.code[3]} ║"
    puts "╚═══╩═══╩═══╩═══╝"
  end

  def guess_number
    @guess_number
  end

  def increase_guess_number
    @guess_number += 1
  end

  def guesses
    @guesses
  end

  def show_this_guess(guess_number)
    puts "╔═══╦═══╦═══╦═══╗"
    puts "║ #{self.guesses[guess_number][0]} ║ #{self.guesses[guess_number][1]} ║ #{self.guesses[guess_number][2]} ║ #{self.guesses[guess_number][3]} ║"
    puts "╚═══╩═══╩═══╩═══╝"
  end

  def show_this_feedback(guess_number)
    puts "╭───┬───╮"
    puts "│ #{self.feedback[guess_number][0]} │ #{self.feedback[guess_number][1]} │"
    puts "├───┼───┤"
    puts "│ #{self.feedback[guess_number][2]} │ #{self.feedback[guess_number][3]} │"
    puts "╰───┴───╯"
  end

  def feedback
    @feedback
  end

  def guess_right?
    self.feedback[self.guess_number - 1] == ["▓", "▓", "▓", "▓"]
  end

  def computer_new_code
    for position in 0..3
      peg_colour = Random.new()
      peg_colour = peg_colour.rand(1..6)
      @code[position] = @@code_pegs[peg_colour]
    end
  end

  def choose_pegs
    4.times do |i|
      puts "Colour #{i+1}:"
      selection = gets.chomp.upcase
      until @@code_pegs.values.include?(selection)
        puts "Not a colour... #{@@code_pegs.values}"
        selection = gets.chomp.upcase
      end
      @guesses[self.guess_number-1][i] = selection
    end
  end

  def generate_feedback
    4.times do |i|
      if !self.code.include?(@guesses[self.guess_number-1][i])
        @feedback[self.guess_number-1][i] = "◯"
        next
      elsif self.code[i] == @guesses[self.guess_number-1][i]
        @feedback[self.guess_number-1][i] = "▓" 
        next
      elsif self.code.include?(@guesses[self.guess_number-1][i])
        @feedback[self.guess_number-1][i] = "░"
      end
    end
    #@feedback[self.guess_number-1].shuffle!
  end

end

game = Mastermind.new
game.computer_new_code
#p game.code


while game.guess_number < 12
  game.increase_guess_number
  puts '', "** GUESS NUMBER #{game.guess_number} of 12 **"
  game.choose_pegs
  game.show_this_guess(game.guess_number - 1)
  game.generate_feedback
  game.show_this_feedback(game.guess_number - 1)
  game.show_code
  if game.guess_right?
    puts '', "You solved it with just #{game.guess_number} guesses! Congratulations!", ''
    break
  end
end

puts '', '*** CODE ***'
game.show_code
