class SearchesController < ApplicationController

  def new
    @search = Search.new
  end

  def create
    @search  = Search.create(search_params)

    render :new
  end

  def update
    @search = Search.find(params[:id])
    @search.update_attributes(search_params)

    render :new
  end

  def show
    @search = Search.find(params[:id])

    render :new
  end

  private

  def search_params
    params[:search].permit!
  end
end
