require 'tty-prompt'
require_relative 'cli.rb'


class User < ActiveRecord::Base

    has_many :reviews
    has_many :apps, through: :reviews
    
    def reviewed_app?(arg)
       self.apps.any?{|app| app == arg}
    end

    def rate_app(app, rating, content)
        if self.reviewed_app?(app)
          target_review = self.reviews.find{|r| r.app == app}
          target_review.rating = rating.to_i
          target_review.content = content
          target_review.save
        #   binding.pry
        else
        Review.create(user: self, app: app, content: content, rating: rating)
      end
    end


end 