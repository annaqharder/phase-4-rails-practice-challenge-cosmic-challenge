class ScientistsController < ApplicationController
    rescue_from ActiveRecord::RecordNotFound, with: :render_not_found
    rescue_from ActiveRecord::RecordInvalid, with: :render_unprocessable_entity_response

    def index
        scientists = Scientist.all
        render json: scientists, status: :ok
    end

    def show
        scientist = find_scientist
        render json: scientist, serializer: ScientistWithPlanetsSerializer, status: :ok

    end

    def create
        scientist = Scientist.create!(scientist_params)
        render json: scientist, status: :created
    end

    def update
        scientist = find_scientist
        scientist.update!(scientist_params)
        render json: scientist, status: :accepted
    end

    def destroy
        scientist = find_scientist
        scientist.destroy
        head :no_content
    end


    private

    def find_scientist
        scientist = Scientist.find(params[:id])
    end

    def scientist_params
        params.permit(:name, :field_of_study, :avatar)
    end

    def render_unprocessable_entity_response(exception)
        render json: { errors: exception.record.errors.full_messages }, status: :unprocessable_entity
    end

    def render_not_found(record)
        render json: { errors: "#{record.model} Not Found"}, status: :not_found
    end

end
