class ApplicationController < ActionController::Base

  add_flash_types :danger, :info, :warning, :success, :messages

  def welcome
  end

  private

    def error_message(errors)
      errors.full_messages.join(', ')
    end
end

