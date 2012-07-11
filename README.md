### IMPORTANT:
  This is a very early version, is not finished for production. This is only some push to the repo for all saved
### Gem Installation using Bundler (The very best way)

Include the latest [gem](http://rubygems.org/gems/refinerycms-polls) into your Refinery CMS application's Gemfile:

    gem 'refinerycms-polls', '~> 0.0.1.dev'

Then type the following at command line inside your Refinery CMS application's root directory:

    bundle install
    
#### Installation on Refinery 2.0.0 or above.

To install the migrations, run:

    rails generate refinery:polls
    rake db:migrate
    
Add pages to the database and you're done:

    rake db:seed
    
## Set vote interval by ip:
After install "generate refinery:polls" you will have an initializer called refinery/poll.rb, you can modify vote interval there.

    Refinery::Polls.configure do |config|
      # Configure how long is going to be valid a vote for a guest
      config.vote_duration = 1.week
    end

## About

__Add polls to your Refinery site.__

In summary you can:

* Create Polls.
* Set anwsers for your polls.
* Set when starts and ends your polls.
* Show results for your polls.
* Set votes for anonymous users by IP addres
* Set aa duration period to vote. (if a guest vote it will need to wait x time to vote again)