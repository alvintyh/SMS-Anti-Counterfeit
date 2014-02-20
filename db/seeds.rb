# -*- encoding : utf-8 -*-
# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)


DaiLy.create(name: 'Đại Lý VNet Cầu Giấy', :admin_user_id => AdminUser.where(email: 'mod@example.com').first.id)
DaiLy.create(name: 'Đại Lý VNet Hoàn Kiếm', :admin_user_id => AdminUser.where(email: 'mod1@example.com').first.id)
DoanhNghiep.create(name: 'Sony Corp', :admin_user_id => AdminUser.where(email: 'user@example.com').first.id, :dai_ly_id => DaiLy.where(name: 'Đại Lý VNet Cầu Giấy'))
DoanhNghiep.create(name: 'Galaxy Corp', :admin_user_id => AdminUser.where(email: 'user1@example.com').first.id, :dai_ly_id => DaiLy.where(name: 'Đại Lý VNet Hoàn Kiếm'))
SanPham.create(name: 'Sony Xperia S', :doanh_nghiep_id => DoanhNghiep.where(name: 'Sony Corp'))
SanPham.create(name: 'Sony Vaio', :doanh_nghiep_id => DoanhNghiep.where(name: 'Sony Corp'))
SanPham.create(name: 'Sony LCD 40inch', :doanh_nghiep_id => DoanhNghiep.where(name: 'Sony Corp'))
SanPham.create(name: 'Galaxy LED 20inch', :doanh_nghiep_id => DoanhNghiep.where(name: 'Galaxy Corp'))
SanPham.create(name: 'Galaxy smart phone', :doanh_nghiep_id => DoanhNghiep.where(name: 'Galaxy Corp'))
SanPham.create(name: 'Galaxy Zenbook', :doanh_nghiep_id => DoanhNghiep.where(name: 'Galaxy Corp'))