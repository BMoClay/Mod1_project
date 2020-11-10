require 'tty-prompt'
require 'pry'
require_relative 'cli.rb'

class Review < ActiveRecord::Base
    
    belongs_to :user
    belongs_to :app

   



end 