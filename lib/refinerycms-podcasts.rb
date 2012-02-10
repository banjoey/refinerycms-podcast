require File.expand_path('../podcasts', __FILE__)

module Refinery
  module Podcasts
    class Engine < Rails::Engine
      initializer "static assets" do |app|
        app.middleware.insert_after ::ActionDispatch::Static, ::ActionDispatch::Static, "#{root}/public"
      end

      config.after_initialize do
        Refinery::Plugin.register do |plugin|
          plugin.name = "podcasts"
          plugin.directory = "podcasts"
          plugin.activity = {:class => Podcast}
        end
        #check/set require parameters
        ::Podcast::FEED_FIELDS.each do |field|
          RefinerySetting.find_or_set(field,'')
        end
      end
    end
  end
end
