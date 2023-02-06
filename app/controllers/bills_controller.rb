class BillsController < ApplicationController
  before_action :set_bill, only: %i[show update destroy]

  def index
    @bills = Bill.ransack(params[:q]).result.includes(:biller, :entity).page(params[:page]).per(params[:per])
  end

  def show; end

  def create
    @bill = Bill.new(bill_params)

    unless @bill.save
      return error(400, @bill.errors.full_messages.first)
    end
  end

  def update
    unless @bill.update(bill_params)
      return error(400, @bill.errors.full_messages.first)
    end
  end

  def destroy
    unless @bill.destroy
      return error(400, @bill.errors.full_messages.first)
    end

    success(200, "Bill #{@bill.name} (#{@bill.biller.name}) deleted successfully")
  end

  private

  def set_bill
    @bill = Bill.find_by(id: params[:id])

    return error(404, "Bill not found") unless @bill.present?
  end

  def bill_params
    params.permit(:account_no, :biller_id, :cadence, :entity_id)
  end
end
