class Mastermind
  attr_reader :code_pegs, :code, :guess_number, :guesses, :feedback, :role, :possible_codes, :computer_guesses

  @@code_pegs = { 1 => 'R', 2 => 'G', 3 => 'B', 4 => 'C', 5 => 'M', 6 => 'Y' }

  def initialize
    puts '', 'Code[m]aker or Code[b]reaker?'
    role = gets.chomp
    @role = role
    @code = Array.new(4)
    @guess_number = 0
    @guesses = Array.new(12) { Array.new(4) }
    @feedback = []
    @possible_codes = 0
    @computer_guesses = Hash.new
  end

  def possible_codes
    @possible_codes = @@code_pegs.values.repeated_permutation(4).to_a
  end

  def guesses
    @guesses
  end

  def feedback
    @feedback
  end

  def show_code
    puts '╔═══╦═══╦═══╦═══╗'
    puts "║ #{self.code[0]} ║ #{self.code[1]} ║ #{self.code[2]} ║ #{self.code[3]} ║"
    puts '╚═══╩═══╩═══╩═══╝'
  end

  def increase_guess_number
    @guess_number += 1
  end

  def show_this_guess(guess_number)
    puts '╔═══╦═══╦═══╦═══╗'
    puts "║ #{self.guesses[guess_number][0]} ║ #{self.guesses[guess_number][1]} ║ #{self.guesses[guess_number][2]} ║ #{self.guesses[guess_number][3]} ║"
    puts '╚═══╩═══╩═══╩═══╝'
  end

  def show_this_feedback(guess_number)
    puts '╭───┬───╮'
    puts "│ #{self.feedback[guess_number][0]} │ #{self.feedback[guess_number][1]} │"
    puts '├───┼───┤'
    puts "│ #{self.feedback[guess_number][2]} │ #{self.feedback[guess_number][3]} │"
    puts '╰───┴───╯'
  end

  def guess_right?
    self.feedback[self.guess_number - 1] == ['▓', '▓', '▓', '▓']
  end

  def computer_new_code
    for position in 0..3
      peg_colour = Random.new
      peg_colour = peg_colour.rand(1..6)
      @code[position] = @@code_pegs[peg_colour]
    end
  end

  def human_new_code
    4.times do |i|
      puts "Colour #{i + 1}:"
      selection = gets.chomp.upcase
      until @@code_pegs.values.include?(selection)
        puts "Not a colour... #{@@code_pegs.values}"
        selection = gets.chomp.upcase
      end
      @code[i] = selection
    end
  end

  def choose_pegs
    4.times do |i|
      puts "Colour #{i + 1}:"
      selection = gets.chomp.upcase
      until @@code_pegs.values.include?(selection)
        puts "Not a colour... #{@@code_pegs.values}"
        selection = gets.chomp.upcase
      end
      @guesses[self.guess_number - 1][i] = selection
    end
  end

  def computer_choose_pegs
    for position in 0..3
      peg_colour = Random.new
      peg_colour = peg_colour.rand(1..6)
      @guesses[self.guess_number - 1][position] = @@code_pegs[peg_colour]
    end
  end

  def generate_feedback(guess)
    temp_code = self.code.dup
    temp_guess = guess.dup
    correct_spot = Array.new
    one_feedback = []
    4.times do |i|
      if temp_code[i] == temp_guess[i]
        one_feedback.push('▓')
        temp_code[i] = ''
        correct_spot.push(i)
      end
    end
    correct_spot.reverse.each { |position| temp_guess.delete_at(position) }
    temp_guess.each do |colour|
      if temp_code.include?(colour)
        one_feedback.push('░')
        temp_code.delete(colour)
      end
    end
    (4 - one_feedback.length).times do
      one_feedback.push(' ')
    end
    one_feedback.shuffle!
  end

end

def generate_feedback_possible_codes(codes)
  all_feedback = []
  #all_codes = self.possible_codes
  codes.each do |code|
    little_feedback = generate_feedback(code)
    all_feedback.push(little_feedback.sort!)
  end

  @computer_guesses = all_codes.zip(all_feedback)
  
end



game = Mastermind.new

if game.role == 'b'
  game.computer_new_code
  puts '', 'Code has been set'
else
  puts '', 'Set your code...'
  game.human_new_code
end

#game.possible_codes
  all_feedback = []
  all_codes = game.possible_codes
  all_codes.each do |code|
    little_feedback = game.generate_feedback(code)
    all_feedback.push(little_feedback.sort!)
  end

 @computer_guesses = all_codes.zip(all_feedback)
 p @computer_guesses.length

while game.guess_number < 12
  game.increase_guess_number
  puts '', "** GUESS NUMBER #{game.guess_number} of 12 **"
  game.role == 'b' ? nil : gets
  game.role == 'b' ? game.choose_pegs : game.computer_choose_pegs
  puts ''
  
  game.feedback.push(game.generate_feedback(game.guesses[game.guess_number - 1]))
  
  (0..(game.guess_number - 1)).each do |guess|
    puts '-----------------'
    game.show_this_guess(guess)
    game.show_this_feedback(guess)
    @computer_guesses.delete_if{|_,v| v == game.feedback[guess].sort}
    p @computer_guesses.length
  end

  
  if game.guess_right?
    puts '', game.role == 'b' ? 'You' : 'Computer' + " solved it with just #{game.guess_number} guesses! Congratulations!", ''
    break
  end
end

puts '', '*** CODE ***'
game.show_code
puts ''
