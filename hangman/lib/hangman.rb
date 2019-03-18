require './lib/stick_figure.rb'
# Hangman game
class Hangman
  attr_reader :secret

  def initialize
    @secret = pick_random_word
    @chances = 9
    @guess = ''
    @secret.length.times do
      @guess += '_'
    end
    @guesses = ''
  end

  def pick_random_word
    chosen = nil
    n = 1
    File.foreach("5desk.txt").each do |word|
      if word.length.between?(5, 12)
        chosen = word if rand < 1.0/(n)
        n += 1
      end
    end
    chosen.chomp
  end

  def get_input
    puts "Enter your guess"
    g = gets.chomp.downcase.ord
    if g.between?(97, 122)
      return g.chr
    else
      get_input
    end
  end

  def check_guess(c)
    a = @secret.split(//).each_index.select { |l| @secret[l] == c }
    if a.size == 0
      @chances -= 1
      puts "nil"
      @guesses += c
      puts 'Wrong Guess'
    else
      a.each { |i| @guess[i] = c }
      puts "true #{a}"
    end
  end

  def out
    system "clear"
    puts @guess
    draw(@chances)
    puts "\nPrevious guesses : #{@guesses}" if @guesses != ''
  end

  def game_start
    until game_over?
      out
      check_guess(get_input)
    end
    out
    if game_won?
      puts "You Won!"
    else
      puts "You lost"
      puts @secret
    end
  end

  def game_won?
    @secret == @guess
  end

  def game_over?
    game_won? || @chances == 0
  end
end
