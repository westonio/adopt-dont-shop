class ApplicationsController < ApplicationController
  
  def new
  end

  def create
    application = Application.create(app_params)
    redirect_to "/applications/#{application.id}"
  end

  def show
    @application = Application.find(params[:id])
    if params[:name]
      @pets = Pet.search(params[:name])
    end
  end  

private
  def app_params
    params.permit(:name, :street_address, :city, :state, :zip_code, :description, :status)
  end
end