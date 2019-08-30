require_dependency "projects_helper"

module AdvancedRoadmap
  module ProjectsHelperPatch
    extend ActiveSupport::Concern

    included do
      alias_method :project_settings_tabs_without_more_tabs, :project_settings_tabs
      alias_method :project_settings_tabs, :project_settings_tabs_with_more_tabs
    end

    def project_settings_tabs_with_more_tabs
      tabs = project_settings_tabs_without_more_tabs
      index = tabs.index{|h| h[:name] == 'versions' }
      if index
        tabs.insert(index, {:name => "milestones", :action => :manage_milestones, :partial => "projects/settings/milestones", :label => :label_milestone_plural})
        tabs.select {|tab| User.current.allowed_to?(tab[:action], @project)}
      end
      return(tabs)
    end
  end
end
