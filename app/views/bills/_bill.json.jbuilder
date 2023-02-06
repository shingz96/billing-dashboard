json.id bill.id
json.name bill.name
json.account_no bill.account_no
json.cadence bill.cadence

json.bill_info do
  json.merge! bill.bill_info
end

json.biller do
  json.partial! 'billers/biller', biller: bill.biller
end

json.entity do
  json.partial! 'entities/entity', entity: bill.entity
end
