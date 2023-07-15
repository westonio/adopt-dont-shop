class ApplicationsController < ApplicationController
  
  def new
  end

  def create
    application = Application.new(app_params)
    if application.save
      redirect_to "/applications/#{application.id}"
      flash[:alert] = "Application Started Successfully!"
    else
      redirect_to "/applications/new"
      flash[:alert] = "Error: #{error_message(application.errors)}"
    end
  end

  def show
    @application = Application.find(params[:id])
    if params[:name]
      @pets = Pet.where("name LIKE ?", params[:name])
    end
  end  

private
  def app_params
    params.permit(:name, :street_address, :city, :state, :zip_code, :description, :status)
  end
end