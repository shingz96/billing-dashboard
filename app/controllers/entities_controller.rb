class EntitiesController < ApplicationController
  before_action :set_entity, only: %i[show update destroy]

  def index
    @entities = Entity.ransack(params[:q]).result.page(params[:page]).per(params[:per])
  end

  def show; end

  def create
    @entity = Entity.new(entity_params)

    unless @entity.save
      return error(400, @entity.errors.full_messages.first)
    end
  end

  def update
    unless @entity.update(entity_params)
      return error(400, @entity.errors.full_messages.first)
    end
  end

  def destroy
    unless @entity.destroy
      return error(400, @entity.errors.full_messages.first)
    end

    success(200, "Entity #{@entity.name} deleted successfully")
  end

  private

  def set_entity
    @entity = Entity.find_by(id: params[:id])

    return error(404, "Entity not found") unless @entity.present?
  end

  def entity_params
    params.permit(:name)
  end
end
