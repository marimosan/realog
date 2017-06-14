# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
Log.delete_all
Auth.delete_all
Flg.delete_all

Log.create(:name => 'マリモさん', :content => '初期値用ダミーデータ', :date => '2017/01/01 11:11')
Auth.create(:pass => Digest::MD5.hexdigest(ENV['ROOM_PASSWORD'] + "real"))
Flg.create(:name => '最終更新日時フラグ')
