class Admin::SheltersController < ApplicationController

  def index
    @shelters_with_pending_applications = Shelter.pending_applications
  end

end