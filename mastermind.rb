class PlayGame
  attr_accessor :code_pegs

  @@code_pegs = {1=>'R',2=>'G',3=>'B',4=>'C',5=>'M',6=>'Y'}

  def initialize
    #attr_accessor :code

    @code = Array.new(4)
  end

  def code
    @code
  end

  def computer_new_code
    for position in 0..3
      peg_colour = Random.new()
      peg_colour = peg_colour.rand(1..6)
      @code[position] = @@code_pegs[peg_colour]
    end
  end

end

game = PlayGame.new()
game.computer_new_code
p game.code


