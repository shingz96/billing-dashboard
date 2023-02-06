# frozen_string_literal: true

class ApplicationController < ActionController::Base
  def success(code, message)
    render json: { code: code, message: message }, status: code
  end
  alias_method :error, :success
end
