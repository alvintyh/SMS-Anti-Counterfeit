# -*- encoding : utf-8 -*-
class Ability
  include CanCan::Ability

  def initialize(user)
    # Define abilities for the passed in user here. For example:
    #
         #user ||= AdminUser.new

     #     if user.role == "admin" :admin 
          can :read, ActiveAdmin::Page, :name => "Dashboard"
          can :manage, ActiveAdmin::Page, :name => "Baocao"
          
          #can :manage, DoanhNghiep if user.role == "mode"
          if user.role == "admin"
            #scan :manage, :all
            can :manage, DaiLy
            can :manage, DoanhNghiep
            #can :manage, PrintManager
            #can :read, Package
            can :read, DangkiCaptem
            can :update, DangkiPhattem
            can :read, Package
            can :read, Smsdb
            can :read, PrintManager
            #can :manage, Captem
            can [:read, :update, :create], AdminUser

            
            can :read, SanPham
            #cannot :create, [ DoanhNghiep, PrintManager, Package, Codegen]
            #cannot :manage, [PrintManager,Package, Codegen, ErrorMessage, Ptype]

          elsif user.role == "mode"
            
            can :create, [DoanhNghiep] 
            can :read, AdminUser, :id => user.id
            can :create, AdminUser
            #can :update, [AdminUser, 
            can :read, DangkiCaptem, :dai_ly => { :admin_user_id => user.id}
            can :create, [DangkiCaptem]
            can :update, [DangkiPhattem]
            can :read, DangkiPhattem, :san_pham => {:doanh_nghiep => {:dai_ly => {:admin_user_id => user.id}}}
            can [:read], [DoanhNghiep], :dai_ly => {:admin_user => {:id => user.id}}
            can :create, DoanhNghiep#, :dai_ly => {:admin_user_id => user.id}
            can :update, DoanhNghiep
            #can :manage, DoanhNghiep#, :dai_ly => {:admin_user_id => user.id} 
            #can :view, DoanhNghiep, :dai_ly => {:admin_user_id => user.id}
            can :destroy, DoanhNghiep

            can :read, SanPham, :doanh_nghiep => {:dai_ly => {:admin_user_id => user.id}}
            can :read, DaiLy, :admin_user_id => user.id
            can :manage, DaiLy
            can :create, DaiLy
            can :read, Captem
            can :read, Phattem
            can :manage, Dnfile
            #can :read, SanPham, :doanh_nghiep => {:dai_ly => {:admin_user => {:id => user.id}}}
            #can :manage, DaiLy, :admin_user_id => user.id

            #can :manage, DaiLyQuanLy, :admin_user_id => user.id
            #cannot view dailyquanly
            #cannot :destroy, [AdminUser, DaiLy]
            #cannot :create, [DaiLy], :admin_user_id => user.id

          elsif user.role == "norm"
            can :read, [AdminUser], :id => user.id
            can :create, AdminUser
            can :update, AdminUser
            can :read, Phattem
            can :read, [SanPham], :doanh_nghiep => {:admin_user_id => user.id}
            can :create, SanPham 
            can :update, SanPham
            #can :read, SanPham#, :doanh_nghiep => {:admin_user_id => user.id}
            can :read, DangkiPhattem, :san_pham => {:doanh_nghiep => {:admin_user_id => user.id}}
            can :create, DangkiPhattem#, :san_pham => {:doanh_nghiep => {:admin#, :san_pham
            can :destroy, DangkiPhattem
            can :read, DoanhNghiep
            can :create, DoanhNghiep
            can :read, Smsdb, :print_manager => {:package => {:captem => {:phattem => {:san_pham => {:doanh_nghiep => {:admin_user_id => user.id}}}}}}
            can :create, Smsdb
            can :update, Smsdb
            can :read, Dnfile
            can :create, Dnfile
            #can :manage, Baocao
            #can :read, Captem
            #can :manage, Captem
            #can :read, [PrintManager]#, :san_pham => {:doanh_nghiep => {:admin_user_id => user.id}}#, :admin_user_id => user.id
            #can :read, Package
            #can :read, [ DoanhNghiep] 
            #can :read,  :san_pham => {:doanh_nghiep => {:dai_ly => {:admin_user => {:id => user.id}}}}#, :admin_user_id => user.id
            #can :read, DoanhNghiep, :admin_user_id => user.id
            #can :update, [DoanhNghiep, AdminUser]
            #cannot :create, DoanhNghiep
          end

          #if user.role == "norm"
          #  can :manage, SanPham
          #  can :manage, DoanhNghiep
          #end
          #can :read, ActiveAdmin::Page, :name => "Dashboard"
         #cannot [:destroy,:edit], SanPham   

    # The first argument to `can` is the action you are giving the user 
    # permission to do.
    # If you pass :manage it will apply to every action. Other common actions
    # here are :read, :create, :update and :destroy.
    #
    # The second argument is the resource the user can perform the action on. 
    # If you pass :all it will apply to every resource. Otherwise pass a Ruby
    # class of the resource.
    #
    # The third argument is an optional hash of conditions to further filter the
    # objects.
    # For example, here the user can only update published articles.
    #
    #   can :update, Article, :published => true
    #
    # See the wiki for details:
    # https://github.com/ryanb/cancan/wiki/Defining-Abilities
  end
end
