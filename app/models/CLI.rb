require 'tty-prompt'
require 'pry'


class CLI

    # @@prompt = TTY::Prompt.new
    #  @@user = nil
 
    def self.tty_prompt
        TTY::Prompt.new 
    end

    def self.main_menu
        system('clear') 
        puts "Welcome to App Quest!"
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
        new_name = prompt.ask("New Username:").strip
        @user.username = new_name
        @user.save
        puts "Your new username is #{new_name}!"
        sleep(3)
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
            @user.destroy
            puts "Your account has been deleted" 
            sleep(2)
            system('clear')
            self.main_menu
        elsif splash == "No"
            system('clear')
            sleep(2)
            self.login_main_menu
        end 
    end 

    def  self.back_to_main_menu
        prompt = TTY::Prompt.new
        splash = prompt.select(" ") do |prompt|
            prompt.choice "Back to Main Menu"
        end
        if splash == "Back to Main Menu"
            system('clear')
            self.login_main_menu
        end
    end

    def self.login_main_menu
        #self.logo
        puts "Welcome #{@user.username}!" 
        intro_screen = self.tty_prompt.select("Main Menu") do |prompt| 
            prompt.choice "Write A Review"
            prompt.choice "Read Your Reviews"
            prompt.choice "Change Username"
            prompt.choice "Logout"
            prompt.choice "Delete Account"
        end
        case intro_screen
            when "Write A Review"
                self.write_a_review
            when "Read Your Reviews" 
                self.read_a_review 
            when "Change Username"
                self.change_name
            when "Logout"
                system('clear')
                self.main_menu
            when "Delete Account"
                self.delete_account
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
            rating = prompt.ask ("Rate the app between 1 and 10").strip 
                content = prompt.ask ("Write a review").strip
                # binding.pry
                @user.rate_app(App.first, rating, content)
                 puts "Your review has been created :)"
                    sleep (2)
                    puts "Taking you back to the main menu.."
                    system('clear')
                    self.login_main_menu
            elsif
                intro_screen == "Yelp" 
                rating = prompt.ask ("Rate the app between 1 and 10").strip 
                content = prompt.ask ("Write a review").strip       
                @user.rate_app(App.second, rating, content)
                    puts "Your review has been created :)"
                    sleep (2)
                    puts "Taking you back to the main menu.."
                    system('clear')
                    self.login_main_menu
            else
                intro_screen == "Instagram" 
                rating = prompt.ask ("Rate the app between 1 and 10").strip 
                content = prompt.ask ("Write a review").strip
                   @user.rate_app(App.third, rating, content)    
                    puts "Your review has been created :)"
                    sleep (2)
                    puts "Taking you back to the main menu.."
                    system('clear')
                    self.login_main_menu
            end 
        end
    
    def self.read_a_review
        @user.reload
        prompt = TTY::Prompt.new
        puts "Which review would you like to read?"
        intro_screen = self.tty_prompt.select("Reviews") do |prompt|
            @user.reviews.each do |review|
                prompt.choice "#{review.app.name} review"
            end
        end 
        this_review = @user.reviews.find{|review| intro_screen.include?(review.app.name)}
        # binding.pry
            if intro_screen = "#{this_review.app.name} review"
                this_review.reload
                puts this_review.rating 
                puts this_review.content
            end
            self.back_to_main_menu
    end

end

