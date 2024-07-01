require 'open-uri'

class GamesController < ApplicationController


  def new
    @letters = Array.new(10){('A'..'Z').to_a.sample}
  end

  def score
    @word = params[:word]
    @letters = params[:letters]
    @included = included_in_grid?(@word, @letters)
    @english = english_word?(@word)
  end

private

  def included_in_grid?(word, letters)
    word.chars.all? { |letter| word.count(letters) <= @letters.count(letters) }
  end

  def english_word?(word)
    response = URI.open("https://dictionary.lewagon.com/#{word}").read
    json = JSON.parse(response)
    json['found']
  end
end
