class Admin::ApplicationsController < ApplicationController
  def show
    @application = Application.find(params[:id])
    @pets = @application.pets
  end

  def update
    application = Application.find(params[:application_id])
    pet_application = application.find_pet_app(params[:pet_id])
    pet_application.update(status: params[:status])
    pet_application.save

    redirect_to "/admin/applications/#{application.id}"
  end
end