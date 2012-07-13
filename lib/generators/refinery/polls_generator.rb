module Refinery
  class PollsGenerator < Rails::Generators::Base
    source_root File.expand_path('../templates', __FILE__)
    
    def rake_db
      rake("refinery_polls:install:migrations")
      rake("refinery_polls:install:migrations")
    end
    
    def generate_poll_initializer
      template "config/initializers/refinery/poll.rb.erb", File.join(destination_root, "config", "initializers", "refinery", "poll.rb")
    end
    
    def generate_styles_to_assets
      template "app/assets/stylesheets/refinery/polls/poll.css.scss", File.join(destination_root, "app", "assets", "stylesheets", "refinery", "polls", "poll.css.scss")
    end
    
    def append_load_seed_data
      create_file 'db/seeds.rb' unless File.exists?(File.join(destination_root, 'db', 'seeds.rb'))
      append_file 'db/seeds.rb', :verbose => true do
        <<-EOH
        
# Added by Refinery CMS Poll engine
Refinery::Polls::Engine.load_seed
        EOH
      end
    end
  end
end
