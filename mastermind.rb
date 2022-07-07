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

  def guess_number
    @guess_number
  end

  def increase_guess_number
    @guess_number += 1
  end

  def guesses
    @guesses
  end

  def feedback
    @feedback
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
        @feedback[self.guess_number-1][i] = ""
        next
      elsif self.code[i] == @guesses[self.guess_number-1][i]
        @feedback[self.guess_number-1][i] = "▓" 
        next
      elsif self.code.include?(@guesses[self.guess_number-1][i])
        @feedback[self.guess_number-1][i] = "░"
      end
    end
  end

end

game = Mastermind.new()
game.computer_new_code

p game.code

game.increase_guess_number
p game.guess_number
game.choose_pegs
p game.guesses
game.generate_feedback
p game.feedback

game.increase_guess_number
p game.guess_number
game.choose_pegs
p game.guesses
game.generate_feedback
p game.feedback





