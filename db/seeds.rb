require 'pry'
require 'rest-client' # in order to make HTTP requests from a ruby file
require 'json'

User.destroy_all
Review.destroy_all
App.destroy_all


# AI: Seed with 100 categories from the API 
# api_resp = RestClient.get("http://jservice.io/api/categories?count=100")
# api_data = JSON.parse(api_resp


# api_data.each { |cat| Category.create( api_id: cat["id"], title: cat["title"] )}
# Category.create(api_data) NOT GONNA WORK B/C ADNTL KEY FROM API 




# Users
User.create([
    {username: "Ben"},
    {username: "Josh"},
    {username: "Maggie"},
    {username: "Dakota"},
    {username: "Stella"}
])

u1 = User.first
u2 = User.second
u3 = User.third

#App

App.create([
    {name: "Facebook", app_function: "Social media company"},
    {name: "Yelp", app_function: "Reviewing food and restaurants"}, 
    {name: "Instagram", app_function: "Posting and commenting on photos"}
])

a1 = App.first
a2 = App.second
a3 = App.third


#Review

Review.create([
    {user_id: User.first.id, app_id: App.first.id, content: "We don't like Facebook!", rating: 1}, 
    {user_id: User.second.id, app_id: App.second.id, content: "We don't like Facebook!", rating: 4},
    {user_id: User.third.id, app_id: App.third.id, content: "We don't like Facebook!", rating: 5}
])



# binding.pry

# User.create(username: "Caryn", password: "12345")
