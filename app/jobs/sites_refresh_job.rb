class SitesRefreshJob < ApplicationJob
  queue_as :default

  def perform(*args)
    Site.all.each do |site|
      site.refresh!
    end
  end
end
