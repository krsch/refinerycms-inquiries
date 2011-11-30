require File.expand_path('../inquiries', __FILE__)

module Refinery
  module Inquiries
    class Engine < Rails::Engine
      config.to_prepare do
        require 'aasm'
      end

      config.after_initialize do
        Refinery::Plugin.register do |plugin|
          plugin.pathname = root
          plugin.name = "refinery_inquiries"
          plugin.directory = "inquiries"
          plugin.menu_match = /(refinery|admin)\/inquir(ies|y_settings|y_categories)$/
          plugin.activity = {
            :class => InquirySetting,
            :title => 'name'
          }
        end
      end
    end
  end
end
