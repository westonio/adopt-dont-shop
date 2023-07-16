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
      @pets = Pet.search(params[:name])
    end
  end  

  def update
    application = Application.find(params[:application_id])
    application.update(app_params)
    application.save

    redirect_to "/applications/#{application.id}"
  end

private
  def app_params
    params.permit(:name, :street_address, :city, :state, :zip_code, :description, :status)
  end
end