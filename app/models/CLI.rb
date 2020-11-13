require 'tty-prompt'
require 'pry'


class CLI


    def self.tty_prompt
        TTY::Prompt.new 
    end

    # @@prompt = TTY::Prompt.new
     @@user = nil
    
    def self.main_menu
        system('clear') 
        puts "Welcome to App Quest!"
            #self.logo would go here
        intro_screen = self.tty_prompt.select("Please Log In or Sign Up!") do |prompt| 
            prompt.choice "Log In"
            prompt.choice "Sign Up"
        end
        case intro_screen 
        when "Log In"
            self.login 
        when "Sign Up"
            self.signup 
        end
    end

    def self.login 
        prompt = self.tty_prompt 
        username = prompt.ask("Username:")
        password = prompt.mask("Password:")
        @user = User.find_by(username: username, password: password)
            if @user 
                system('clear')
                self.login_main_menu 
            else
                puts "Invalid username or password."
                sleep(2)
                system('clear')
                self.main_menu  
            end
        end
    


    def self.change_name
        prompt = self.tty_prompt
        username = prompt.ask("New Username:")
           @user = User.create(username: username, password: password)
           system('clear')
           self.login_main_menu
       
    end     
 
    def self.tty_prompt
        TTY::Prompt.new 
    end

    def self.main_menu
        system('clear') 
        puts "Welcome to App Quest!"
            #self.logo would go here
        intro_screen = self.tty_prompt.select("Please Log In or Sign Up!") do |prompt| 
            prompt.choice "Log In"
            prompt.choice "Sign Up"
        end
        case intro_screen 
        when "Log In"
            self.login 
        when "Sign Up"
            self.signup 
        end
    end

    def self.login 
        prompt = self.tty_prompt 
        username = prompt.ask("Username:")
        password = prompt.mask("Password:")
        @user = User.find_by(username: username, password: password)
        if @user 
            system('clear')
            self.login_main_menu 
        else
            puts "Invalid username or password."
            sleep(2)
            system('clear')
            self.main_menu  
        end
    end

    def self.signup 
        prompt = self.tty_prompt
        username = prompt.ask("Username:")
        password = prompt.mask("Password:")
        @user = User.create(username: username, password: password)
        system('clear')
        self.login_main_menu
    end

    def self.change_name
        prompt = self.tty_prompt
        username = prompt.ask("New Username:")
        @user = User.create(username: username, password: password)
        system('clear')
        self.login_main_menu
    end 

    def self.delete_account
        prompt = TTY::Prompt.new 
        splash = prompt.select("Are you sure you want to delete your account?") do |prompt| 
            prompt.choice "Yes"
            prompt.choice "No"
        end
        if splash == "Yes"
            @user.destroy_all
            puts "Your account has been deleted" 
        elsif splash == "No"
            self.back_to_main_menu
        end 
    end 

    def  self.back_to_main_menu
        prompt = TTY::Prompt.new
        splash = prompt.select("Go Back") do |prompt|
            prompt.choice "Back to Main Menu"
        end
        if splash == "Back to Main Menu"
            system('clear')
            self.login_main_menu
        end
    end

    def self.reviews
        Review.all.map{|r| r.rating && r.content}
    end

    def self.users
        User.all.map{|u| u.username}
    end

    def self.login_main_menu
        #self.logo
        puts "Welcome #{@user.username}!" 
        intro_screen = self.tty_prompt.select("Main Menu") do |prompt| 
            prompt.choice "Write A Review"
            prompt.choice "Read A Review"
            prompt.choice "Edit A Review"
            prompt.choice "Logout"
        end
        case intro_screen
            when "Read A Review" 
                self.read_a_review
            when "Write A Review"
                self.write_a_review 
            when "Edit A Review or Change Rating"
                self.edit_a_review_or_rating
            when "Logout"
                system('clear')
                self.main_menu
        end
    end

    def self.write_a_review
        prompt = TTY::Prompt.new
        intro_screen = self.tty_prompt.select("Write A Review") do |prompt|
        puts "What app would you like to review?"
        prompt.choice "#{App.first.name}"
        prompt.choice "#{App.second.name}"
        prompt.choice "#{App.third.name}"
        end        
            if intro_screen == "Facebook" 
            prompt.ask "Rate the app between 1 and 10" 
                rating = gets.chomp 
            prompt.ask "Write a review"
                content = gets.chomp
                 Review.create({user: @user, app: App.first, content: content, rating: rating})
                 puts "Your review has been created :)"
                    sleep (2)
                    puts "Taking you back to the main menu.."
                    main_menu
            elsif
                intro_screen == "Yelp" 
                prompt.ask "Rate the app between 1 and 10" 
                    rating = gets.chomp 
                prompt.ask "Write a review"
                    content = gets.chomp        
                    Review.create({user: @user, app: App.second, content: content, rating: rating})
                    puts "Your review has been created :)"
                    sleep (2)
                    puts "Taking you back to the main menu.."
                    main_menu
            else
                intro_screen == "Instagram" 
                prompt.ask "Rate the app between 1 and 10" 
                    rating = gets.chomp 
                prompt.ask "Write a review"
                    content = gets.chomp        
                    Review.create({user: @user, app: App.third, content: content, rating: rating})                   
            puts "Your review has been created :)"
                    sleep (2)
                    puts "Taking you back to the main menu.."
                    main_menu
            end 
        end

   
            # else
            #     puts "You have already rated this movie"
            #     choice = @@prompt.select("Would you like to update your rating?", %w(Yes No))
            #     case choice
            #     when "Yes"
            #         puts "What is the new rating for this movie?"
            #         rating = rate()
            #         Rating.all.find_by(user: @@user,movie: selection).update(rating: rating)
            #         puts "The rating for this movie has been updated!"
            #         sleep (2)
            #         puts "Taking you back to the main menu.."
            #         sleep(2)
            #         main_menu
            #     when "No"
            #         puts "Taking you back to the main menu.."
            #         sleep (2)
            #         main_menu
            #     end
            # end
    #     else
    #         spinner
    #         puts "No movies found by that title, try again"
    #         sleep(2)
    #         self.search_for_movie
    #     end
    # end
    
    def self.read_a_review
        prompt = TTY::Prompt.new
        intro_screen = self.tty_prompt.select("Reviews") do |prompt|
        puts "Which review would you like to read?"
        Review.all
        prompt.choice "#{Review.first}"
        prompt.choice "#{@user.username}'s review"
            all_my_reviews = Review.all.select{|r| r.user == self}
            return all_my_reviews
        # prompt.choice "#{App.first.name}"
        # prompt.choice "#{App.second.name}"
        # prompt.choice "#{App.third.name}"
            
        end
    end
end

