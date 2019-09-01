require 'open-uri'
require 'json'

class GamesController < ApplicationController
  def new
    @letters = Array.new(10) { ('A'..'Z').to_a.sample }
    @letters = @letters.join("")
  end

  def score
    # raise
    if included?(params[:word].upcase, params[:grid])
      if english_word?(params[:word])
        @score = "well done"
      else
        @score = "#{params[:word]} is not an english word"
      end
    else
      @score = "#{params[:word]} is not made out of the letters provided"
    end
  end

  def english_word?(word)
    response = open("https://wagon-dictionary.herokuapp.com/#{word}")
    json = JSON.parse(response.read)
    return json['found']
  end

  def included?(guess, grid)
    guess.chars.all? { |letter| guess.count(letter) <= grid.count(letter) }
  end

end
