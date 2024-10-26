class LinksController < ApplicationController
  def show
    @link = Link.find_by(slug: params[:slug])
    if @link
      @link.increment!(:clicked)
      redirect_to @link.url
    else
      render plain: '404 Not Found', status: 404
    end
  end

  def new
    @link = Link.new
  end

  def create
    @link = Link.new(link_params)
    if @link.save
      redirect_to @link.short
    else
      render :new
    end
  end

  private

  def link_params
    params.require(:link).permit(:url, :slug)
  end
end
