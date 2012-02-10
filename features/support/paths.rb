module NavigationHelpers
  module Refinery
    module Podcasts
      def path_to(page_name)
        case page_name
        when /the list of podcasts/
          '/refinery/podcasts'

         when /the new podcast form/
          '/refinery/podcasts/new'
        else
          nil
        end
      end
    end
  end
end

