class Admin::SheltersController < ApplicationController

  def index
    @shelters_with_pending_applications = Shelter.pending_applications
    @shelters = Shelter.order_by_name_desc
  end

end