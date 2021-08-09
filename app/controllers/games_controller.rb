require 'json'
require 'open-uri'

class GamesController < ApplicationController
  def new
    @letters = []
    alphabet = ('A'..'Z').to_a
    10.times { @letters.push(alphabet.sample) }
  end

  def score
    input = params[:try]
    url = "https://wagon-dictionary.herokuapp.com/#{input}"
    input_object = URI.open(url).read
    input_hash = JSON.parse(input_object)
    control = params[:letters]
    # @score_value = 0
    if input_hash['found'] == true && input.chars.all? { |a| control.count(a.upcase) >= input.chars.count(a) }
      @score = "Good job! #{input.capitalize} is an english word!"
      session[:user_score] += input.length
    elsif input_hash['found'] == false
      @score = "Oh no.. #{input} doesn't seem to be an english word. "
    else
      @score = "Oh no.. #{input} can't be built out of #{control}"
    end
  end
end
