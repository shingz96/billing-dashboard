json.billers @billers, partial: 'billers/biller', as: :biller

json.partial! partial: 'jbuilder/partials/metadata', models: @billers
