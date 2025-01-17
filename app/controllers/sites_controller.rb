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
    if @site.refresh && @site.save
      redirect_to root_path
    else
      render :new, status: :unprocessable_entity
    end
  end

  def update
    @site = Site.find(params[:id])
    @site.assign_attributes(site_params)
    if @site.refresh && @site.save
      redirect_to root_path
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @site = Site.find(params[:id])
    @site.destroy!
    redirect_to root_path
  end

  def site_params
    params.expect(site: %i[name url prefix])
  end
end
