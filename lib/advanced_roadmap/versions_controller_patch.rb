require_dependency "versions_controller"

module AdvancedRoadmap
  module VersionsControllerPatch
    def index
      super
      @totals = Version.calculate_totals(@versions)
      Version.sort_versions(@versions)

      @issues_by_version.each do |versions|
        versions.last.delete_if { |issue | issue.closed? }
      end if params[:only_open]
    end

    def show
      @issues = @version.sorted_fixed_issues
    end
  end
end
