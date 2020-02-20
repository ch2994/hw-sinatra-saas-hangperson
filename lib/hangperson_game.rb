class HangpersonGame

  # add the necessary class methods, attributes, etc. here
  # to make the tests in spec/hangperson_game_spec.rb pass.

  # Get a word from remote "random word" service

  # def initialize()
  # end
  attr_accessor :word, :guesses, :wrong_guesses

  def initialize(word)
    @word = word
    @guesses = ''
    @wrong_guesses = ''
  end

  def guess(letter)
    raise ArgumentError if letter.nil?
    raise ArgumentError if letter.empty?
    raise ArgumentError if (letter =~ /[[:alpha:]]/).nil?

    letter = letter.downcase
    result = true
    if @word.include?(letter)
      if !@guesses.include?(letter)
        @guesses += letter
      else
        result = false
      end
    else
      if !@wrong_guesses.include?(letter)
        @wrong_guesses += letter
      else
        result = false
      end
    end
    result
  end

  def word_with_guesses()
    result = '-' * @word.length
    guesses.split('').each do |c|
      @word.split('').each_with_index do |v, i|
        if c == v
          result[i] = c
        end
      end
    end
    result
  end

  def check_win_or_lose()
    if @wrong_guesses.length >= 7
      :lose
    elsif @word.delete(@guesses) == ''
      :win
    else
      :play
    end
  end


  # You can test it by running $ bundle exec irb -I. -r app.rb
  # And then in the irb: irb(main):001:0> HangpersonGame.get_random_word
  #  => "cooking"   <-- some random word
  def self.get_random_word
    require 'uri'
    require 'net/http'
    uri = URI('http://watchout4snakes.com/wo4snakes/Random/RandomWord')
    Net::HTTP.new('watchout4snakes.com').start { |http|
      return http.post(uri, "").body
    }
  end

end
