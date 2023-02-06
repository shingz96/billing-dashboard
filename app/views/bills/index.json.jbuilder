json.bills @bills, partial: 'bills/bill', as: :bill

json.partial! partial: 'jbuilder/partials/metadata', models: @bills
