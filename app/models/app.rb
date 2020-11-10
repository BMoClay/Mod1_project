require 'tty-prompt'
require 'pry'
require_relative 'cli.rb'

class App < ActiveRecord::Base

    has_many :reviews
    has_many :users, through: :reviews



end 