# encoding: UTF-8
# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your
# database schema. If you need to create the application database on another
# system, you should be using db:schema:load, not running all the migrations
# from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended to check this file into your version control system.

ActiveRecord::Schema.define(:version => 20131001114753) do

  create_table "admin_users", :force => true do |t|
    t.string   "email",                  :default => "", :null => false
    t.string   "encrypted_password",     :default => "", :null => false
    t.string   "role"
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          :default => 0
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.datetime "created_at",                             :null => false
    t.datetime "updated_at",                             :null => false
  end

  add_index "admin_users", ["email"], :name => "index_admin_users_on_email", :unique => true
  add_index "admin_users", ["reset_password_token"], :name => "index_admin_users_on_reset_password_token", :unique => true

  create_table "admin_users_roles", :id => false, :force => true do |t|
    t.integer "admin_user_id"
    t.integer "role_id"
  end

  add_index "admin_users_roles", ["admin_user_id", "role_id"], :name => "index_admin_users_roles_on_admin_user_id_and_role_id"

  create_table "captems", :force => true do |t|
    t.integer  "package_id"
    t.integer  "dai_ly_id"
    t.integer  "issued",     :default => 0
    t.datetime "created_at",                :null => false
    t.datetime "updated_at",                :null => false
    t.datetime "approve_at"
  end

  create_table "codegens", :force => true do |t|
    t.string   "name"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "dai_lies", :force => true do |t|
    t.string   "name"
    t.text     "diachi"
    t.string   "email"
    t.string   "sdt"
    t.integer  "admin_user_id"
    t.datetime "created_at",    :null => false
    t.datetime "updated_at",    :null => false
  end

  create_table "dangki_captems", :force => true do |t|
    t.string   "name"
    t.integer  "dai_ly_id"
    t.integer  "luong_lo"
    t.integer  "approve",    :default => 0
    t.datetime "created_at",                :null => false
    t.datetime "updated_at",                :null => false
    t.datetime "approve_at"
  end

  create_table "dangki_phattems", :force => true do |t|
    t.string   "name"
    t.integer  "san_pham_id"
    t.integer  "luong_lo"
    t.integer  "approve",     :default => 0
    t.datetime "created_at",                 :null => false
    t.datetime "updated_at",                 :null => false
    t.datetime "approve_at"
  end

  create_table "dnfiles", :force => true do |t|
    t.string   "file"
    t.text     "description"
    t.string   "url"
    t.integer  "san_pham_id"
    t.datetime "created_at",  :null => false
    t.datetime "updated_at",  :null => false
  end

  add_index "dnfiles", ["san_pham_id"], :name => "index_dnfiles_on_san_pham_id"
  add_index "dnfiles", ["url"], :name => "index_dnfiles_on_url"

  create_table "doanh_nghieps", :force => true do |t|
    t.string   "name"
    t.string   "ma_so_thue"
    t.text     "dia_chi"
    t.text     "dia_chi_gd"
    t.integer  "dien_thoai"
    t.string   "email"
    t.string   "ng_dai_dien"
    t.integer  "admin_user_id"
    t.integer  "dai_ly_id"
    t.datetime "created_at",    :null => false
    t.datetime "updated_at",    :null => false
    t.string   "dn_tat"
  end

  create_table "error_messages", :force => true do |t|
    t.string   "name"
    t.text     "message"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "packages", :force => true do |t|
    t.string   "name"
    t.integer  "ptype_id"
    t.integer  "issued"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "phattems", :force => true do |t|
    t.integer  "captem_id"
    t.integer  "san_pham_id"
    t.datetime "created_at",  :null => false
    t.datetime "updated_at",  :null => false
    t.datetime "approve_at"
  end

  create_table "print_managers", :force => true do |t|
    t.integer  "package_id"
    t.string   "codegen_name"
    t.integer  "kh",           :default => 0
    t.datetime "created_at",                  :null => false
    t.datetime "updated_at",                  :null => false
    t.integer  "printed",      :default => 0
  end

  create_table "ptypes", :force => true do |t|
    t.string   "name"
    t.text     "description"
    t.datetime "created_at",  :null => false
    t.datetime "updated_at",  :null => false
  end

  create_table "roles", :force => true do |t|
    t.string   "name"
    t.integer  "resource_id"
    t.string   "resource_type"
    t.datetime "created_at",    :null => false
    t.datetime "updated_at",    :null => false
  end

  add_index "roles", ["name", "resource_type", "resource_id"], :name => "index_roles_on_name_and_resource_type_and_resource_id"
  add_index "roles", ["name"], :name => "index_roles_on_name"

  create_table "san_phams", :force => true do |t|
    t.string   "name"
    t.string   "giay_phep"
    t.string   "noi_cap"
    t.date     "ngay_cap"
    t.string   "so_luong"
    t.string   "xuat_xu"
    t.integer  "doanh_nghiep_id"
    t.datetime "created_at",      :null => false
    t.datetime "updated_at",      :null => false
    t.string   "so_giay_phep"
    t.string   "sp_tat"
  end

  create_table "smsdbs", :force => true do |t|
    t.string   "sdt"
    t.string   "error"
    t.text     "message"
    t.integer  "print_manager_id"
    t.datetime "created_at",       :null => false
    t.datetime "updated_at",       :null => false
  end

end
