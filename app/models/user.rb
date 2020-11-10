require 'tty-prompt'
require_relative 'cli.rb'



class User < ActiveRecord::Base

    has_many :reviews
    has_many :apps, through: :reviews
    @@prompt = TTY::Prompt.new


end 