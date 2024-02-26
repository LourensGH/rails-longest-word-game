require 'httparty'

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
      response = HTTParty.get("https://wagon-dictionary.herokuapp.com/#{@word}")
      word_data = JSON.parse(response.body)
      if word_data['found']
        @score += @word.length
      else
        @reply = 'word is not valid'
      end
    end
    session[:score] = @score
  end
end
