class HangpersonGame

  # add the necessary class methods, attributes, etc. here
  # to make the tests in spec/hangperson_game_spec.rb pass.

  # Get a word from remote "random word" service

  # def initialize()
  # end
  
  attr_accessor :word
  attr_accessor :guesses
  attr_accessor :wrong_guesses
  
  def initialize(word)
    @word = word
    @guesses = '' 
    @wrong_guesses = ''
    @tries = 0
  end
  
  def guess(letter)
    raise ArgumentError unless letter != nil
    raise ArgumentError if letter.length == 0
    raise ArgumentError if letter =~ /[^a-zA-Z]/ 
    if word.downcase.include? letter.downcase
      if !guesses.downcase.include? letter.downcase
        guesses << letter
        return true
      end
      return false
    else
      return false if wrong_guesses.downcase.include? letter.downcase
      @tries += 1
      wrong_guesses << letter
      return true
    end
  end

  def word_with_guesses
    return word.gsub(/[^#{guesses}]/,"-") if guesses.length > 0
    word.gsub(/./, "-")
  end

  def check_win_or_lose
    return :win if word == word_with_guesses
    return :lose if @tries > 6
    :play
  end

  def self.get_random_word
    require 'uri'
    require 'net/http'
    uri = URI('http://watchout4snakes.com/wo4snakes/Random/RandomWord')
    Net::HTTP.post_form(uri ,{}).body
  end

end
