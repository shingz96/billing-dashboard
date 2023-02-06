# frozen_string_literal: true

# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)

# Biller
air = Biller.create(code: 'air_selangor', name: 'Air Selangor', url: 'https://www.airselangor.com/')
tnb = Biller.create(code: 'tnb', name: 'TNB', url: 'https://www.mytnb.com.my/')
indah = Biller.create(code: 'indah_water', name: 'Indah Water', url: 'https://www.iwk.com.my/')
unifi = Biller.create(code: 'unifi', name: 'Unifi', url: 'https://unifi.com.my/')
mpkj = Biller.create(code: 'mpkj', name: 'Majlis Perbandaran Kajang (Cukai Taksiran)', url: 'https://ebayar.mpkj.gov.my/ebayar/Public/Tax')
ehasil = Biller.create(code: 'ehasil_selangor', name: 'Portal eHasil Selangor | Cukai Tanah / Cukai Petak', url: 'https://ehasil.selangor.gov.my/quit-rent/public/search')
dbkl = Biller.create(code: 'dbkl', name: 'Dewan Bandaraya Kuala Lumpur (Cukai Taksiran)', url: 'https://cssp.dbkl.gov.my/')
mphs = Biller.create(code: 'mphs', name: 'Majlis Perbandaran Hulu Selangor (Cukai Taksiran)', url: 'https://ebilling.mdhs.gov.my:62001/MDHS/Payment')

# Entity
vista = Entity.create(name: '23, Taman Cheras Vista')
aman = Entity.create(name: '918, Residensi Aman')
supereme = Entity.create(name: '24-2E, Supereme Apartment')
shoplot = Entity.create(name: 'Hulu Langat Shoplot')
kalumpang = Entity.create(name: '192, Kalumpang')
land_cs = Entity.create(name: 'Land (Chee Sui)')
land_ccl = Entity.create(name: 'Land (Chee Chee Leong)')

# Bill
Bill.create(entity: vista, biller: tnb, account_no: '220317010403', cadence: :monthly)
Bill.create(entity: vista, biller: air, account_no: '1703120000', cadence: :monthly)
Bill.create(entity: vista, biller: unifi, account_no: '1003370077', cadence: :monthly)
Bill.create(entity: vista, biller: indah, account_no: '86492048', cadence: :half_yearly)
Bill.create(entity: vista, biller: mpkj, account_no: '51T0337A072-0269930', cadence: :half_yearly)

Bill.create(entity: aman, biller: tnb, account_no: '210191105909', cadence: :monthly)
Bill.create(entity: aman, biller: air, account_no: '0534938073', cadence: :monthly)
Bill.create(entity: aman, biller: indah, account_no: '77204253', cadence: :half_yearly)
Bill.create(entity: aman, biller: mpkj, account_no: '31B0004A046-0364963', cadence: :half_yearly)
Bill.create(entity: aman, biller: ehasil, account_no: '55607115147670', cadence: :yearly)

Bill.create(entity: supereme, biller: tnb, account_no: '220239708009', cadence: :monthly)
# Bill.create(entity: supereme, biller: air, account_no: '', cadence: :monthly)
Bill.create(entity: supereme, biller: indah, account_no: '29892023', cadence: :half_yearly)
Bill.create(entity: supereme, biller: dbkl, account_no: '1611212764935', cadence: :half_yearly)

Bill.create(entity: shoplot, biller: tnb, nickname: 'Shoplot Up', account_no: '220175242905', cadence: :monthly)
Bill.create(entity: shoplot, biller: tnb, nickname: 'Shoplot Down', account_no: '220175249601', cadence: :monthly)
Bill.create(entity: shoplot, biller: air, nickname: 'Shoplot Up', account_no: '4460112108', cadence: :monthly)
Bill.create(entity: shoplot, biller: air, nickname: 'Shoplot Down', account_no: '0787140000', cadence: :monthly)
Bill.create(entity: shoplot, biller: indah, account_no: '87887451', cadence: :half_yearly)
Bill.create(entity: shoplot, biller: mpkj, account_no: '63T0106B008-0251700', cadence: :half_yearly)
Bill.create(entity: shoplot, biller: ehasil, account_no: '50604100854326', cadence: :yearly)

Bill.create(entity: kalumpang, biller: mphs, account_no: '00049973', cadence: :half_yearly)
Bill.create(entity: kalumpang, biller: ehasil, account_no: '50706100070429', cadence: :yearly)

Bill.create(entity: land_cs, biller: ehasil, account_no: '50712100023962', cadence: :yearly)
Bill.create(entity: land_ccl, biller: ehasil, account_no: '50712100074953', cadence: :yearly)
