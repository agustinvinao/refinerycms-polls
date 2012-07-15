# RefineryCMS-Polls extension [![Build Status](https://secure.travis-ci.org/agustinvinao/refinerycms-polls.png?branch=master)](http://travis-ci.org/agustinvinao/refinerycms-polls)

Simple polls extension for RefineryCMS engine.

## IMPORTANT:
  This extension requires Ruby 1.9.x. It's time to upgrade our current ruby base systems.

### Gem Installation using Bundler (The very best way)

Include the latest [gem](http://rubygems.org/gems/refinerycms-polls) into your Refinery CMS application's Gemfile:

```ruby
gem 'refinerycms-polls', '~> 0.0.4.dev'
```

Then type the following at command line inside your Refinery CMS application's root directory:

    bundle install
    
### Installation on Refinery 2.0.0 or above.

To install the migrations, run:

    rails generate refinery:polls
    rake db:migrate
    
Add pages to the database and you're done:

    rake db:seed
    
### Set vote interval by ip:
After install "generate refinery:polls" you will have an initializer called refinery/poll.rb, you can modify vote interval there.

```ruby
Refinery::Polls.configure do |config|
  # Configure how long is going to be valid a vote for a guest
  config.vote_duration = 1.week
end
```

### Render a Poll

You can get all actives polls with:

```ruby
Refinery::Polls::Question.actives
```

all questions will be orderer by default with position value in admin reorder functionality.

And pick up one question to render a poll with the partial "poll":

```ruby
render '/refinery/polls/questions/poll', :question => question
```

Override default view for partial _poll

You can override the default partial view for a poll replacing this partial:
   
```ruby 
/refinery/polls/questions/_poll.html.erb
```

You only need to create that path and file in your app tree.

## About

__Add polls to your Refinery site.__

In summary you can:

* Create Polls.
* Set anwsers for your polls.
* Set when starts and ends your polls.
* Show results for your polls.
* Set votes for anonymous users by IP addres
* Set duration period to vote. (if a guest vote it will need to wait X time to vote again)


## Docs:
* [Documentation"](http://rubydoc.info/github/agustinvinao/refinerycms-polls/frames/file/README.md)
* [CHANGELOG] (https://github.com/agustinvinao/refinerycms-polls/blob/master/CHANGELOG.md)


## Todo

* Vote tracking by cookies.
* Documentation
* Tests
* Wiki


## License
RefineryCMS Polls extension is released under the MIT license and is copyright (c) 2012 Agustin Viñao