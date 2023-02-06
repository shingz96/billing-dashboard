# frozen_string_literal: true

class ApplicationController < ActionController::Base
  skip_before_action :verify_authenticity_token

  def success(code, message)
    render json: { code: code, message: message }, status: code
  end
  alias_method :error, :success
end
