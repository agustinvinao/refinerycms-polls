module Refinery
  module Polls
    class Engine < Rails::Engine
      include Refinery::Engine
      isolate_namespace Refinery::Polls

      engine_name :refinery_polls

      initializer "register refinerycms_polls plugin" do
        Refinery::Plugin.register do |plugin|
          plugin.name = "polls"
          plugin.url = proc { Refinery::Core::Engine.routes.url_helpers.polls_admin_questions_path }
          plugin.pathname = root
          plugin.activity = {
            :class_name => :'refinery/polls/question'
          }
          
        end
      end

      config.after_initialize do
        Refinery.register_extension(Refinery::Polls)
      end
    end
  end
end
