require_dependency "projects_helper"

module AdvancedRoadmap
  module ProjectsHelperPatch
    def project_settings_tabs
      tabs = super
      index = tabs.index({:name => 'versions', :action => :manage_versions, :partial => 'projects/settings/versions', :label => :label_version_plural})
      if index
        tabs.insert(index, {:name => "milestones", :action => :manage_milestones, :partial => "projects/settings/milestones", :label => :label_milestone_plural})
        tabs.select {|tab| User.current.allowed_to?(tab[:action], @project)}
      end
      return(tabs)
    end
  end
end
