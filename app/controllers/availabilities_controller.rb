class AvailabilitiesController < ApplicationController
  def create
    @availability = Availability.new_and_calculate(availability_params)

    if @availability.save
      redirect_to @availability.user, notice: "Availability has been created"
    else
      raise "Oh dang"
    end
  end

  private

  def availability_params
    params.require(:availability).permit!
  end
end
