module AdvancedRoadmap
  module JournalPatch
    def self.prepended(base)
      base.class_eval do
        unloadable
      end
    end

    def visible_details(user=User.current)
      arr = super(user)
      arr.select do |detail|
        if detail.prop_key == "estimated_hours"
          User.current.allowed_to?(:view_issue_estimated_hours, project)
        else
          true
        end
      end
    end
  end
end
