class BillersController < ApplicationController
  skip_before_action :verify_authenticity_token
  before_action :set_biller, only: %i[ show update destroy ]

  def index
    @billers = Biller.all
  end

  def show; end

  def create
    @biller = Biller.new(biller_params)

    unless @biller.save
      return error(400, @biller.errors.full_messages.first)
    end
  end

  def update
    unless @biller.update(biller_params)
      return error(400, @biller.errors.full_messages.first)
    end
  end

  def destroy
    unless @biller.destroy
      return error(400, @biller.errors.full_messages.first)
    end
  end

  private

  def set_biller
    @biller = Biller.find_by(id: params[:id])

    return error(404, "biller not found") unless @biller.present?
  end

  def biller_params
    params.permit(:code, :name, :url)
  end
end
