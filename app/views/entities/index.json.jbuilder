json.entities @entities, partial: 'entities/entity', as: :entity

json.partial! partial: 'jbuilder/partials/metadata', models: @entities
