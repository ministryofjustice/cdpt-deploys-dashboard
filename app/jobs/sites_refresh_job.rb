class SitesRefreshJob < ApplicationJob
  queue_as :default

  def perform(*_args)
    Site.all.find_each(&:refresh!)
  end
end
