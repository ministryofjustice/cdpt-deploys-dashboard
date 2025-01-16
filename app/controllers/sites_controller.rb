class SitesController < ApplicationController
  def index
    @sites = Site.all.order(:name)
  end

  def new
    @site = Site.new
  end

  def edit
    @site = Site.find(params[:id])
  end

  def create
    @site = Site.new(site_params)
    if @site.save
      @site.refresh!
      redirect_to root_path
    else
      render :new, status: :unprocessable_entity
    end
  end

  def update
    @site = Site.find(params[:id])
    if @site.update(site_params)
      @site.refresh!
      redirect_to root_path
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def site_params
    params.expect(site: [ :name, :url, :prefix ])
  end
end
