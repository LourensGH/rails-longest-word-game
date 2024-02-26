class GamesController < ApplicationController
  def new
    @letters = []
    10.times do
      @letters << ('a'..'z').to_a.sample
    end
    session[:letters] = @letters
  end

  def score
    @letters = session[:letters]
    if session[:score] == nil
      session[:score] = 0
    end
    @score = session[:score]
    @word = params[:word]
    letters = @word.chars
    @reply = 'word is valid'
    letters.each do |letter|
      unless @letters.include?(letter)
        @reply = 'letter not included'
        break
      end
    end
    if @reply == 'word is valid'
      @score += @word.length
    end
    session[:score] = @score
  end
end
