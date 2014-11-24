class SearchController < ApplicationController

  def new
  end

  def create
    @search_params = params[:search]
    @results       = AvailabilitySearch.new(@search_params).results

    render :new
  end

  private

  def search_params
    params[:search]

    {"day"=>"2", "input_start"=>"12 pm", "input_end"=>"2 pm", "time_zone"=>"Mountain Time (US & Canada)"}
  end
end
