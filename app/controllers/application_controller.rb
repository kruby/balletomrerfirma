 # Filters added to this controller apply to all controllers in the application.
# Likewise, all the methods added will be available for all controllers.

class ApplicationController < ActionController::Base
  helper :all # include all helpers, all the time
	
  before_filter :set_user_language
  # before_filter :prepare_for_mobile
	
  
  # See ActionController::RequestForgeryProtection for details vi ændrer lidt
  # Uncomment the :secret if you're not using the cookie session store
  protect_from_forgery # :secret => '9cae1eb8594a7b89643fabe15981bf87'
  
  include AuthenticatedSystem
  
  before_filter :get_content_for_menu
  
  def site_is_open
    if logged_in? or Parameter.find_by_name('Adgang').value == "Åben"
     return true
    else
      false
    end
  end
  
  
  def get_content_for_menu
    #Menupunkter i forhold til user.category skal hentes. Er man editor, får man kun aktuelle menupunkter at se.
    #get_subdomain_pages
    
    @main_menu ||= Content.main_menu # main_menu kommer fra content.rb
    
    if logged_in?
      if current_user.category == 'Admin' 
        @tabs ||= Content.admin_pages + Content.editor_pages + Content.user_pages
        # parent_pages kommer fra content.rb (modellen) derfor starter den også med Content. det har ikke noget med tabellen contents at gøre.
        @tabs_main ||= @main_menu
      elsif current_user.category == 'Editor'
        @tabs ||= Content.editor_pages + Content.user_pages
        @tabs_main ||= @main_menu
      elsif current_user.category == 'User'
        @tabs ||= Content.user_pages
        @tabs_main ||= @main_menu
      end
    else
      @tabs_main ||= Content.public_pages
      
    end

  end


  def active
   active_controller = params[:controller].classify.constantize
   @active_controller = active_controller.find(params[:id])
   if @active_controller.active
     @active_controller.active = 0
     #flash[:notice] = 'Jobbet blev til nul'
   else
     @active_controller.active = 1
   #flash[:notice] = 'Jobbet blev til 1'
   end
   
   @active_controller.update_attributes(params[:active_controller])
   
   redirect_to(:action => 'index')
  end
  
  def active_users
    @user = User.find(params[:id])
    if @user.category == 'Admin' and @user.active == true and User.admin.count < 2
        flash[:notice] = 'Kan ikke gøres inaktiv. Altid mindst én "Admin" tilgængelig. '
        redirect_to(:action => 'index')
    else
      active
    end
  end
  
  
  def active_redirect
   active_controller = params[:controller].classify.constantize
   @active_controller = active_controller.find(params[:id])
   if @active_controller.redirect
     @active_controller.redirect = 0
     #flash[:notice] = 'Jobbet blev til nul'
   else
     @active_controller.redirect = 1
   #flash[:notice] = 'Jobbet blev til 1'
   end
   
   @active_controller.update_attributes(params[:active_controller])
   
   redirect_to(:action => 'index')
  end
  
  
  def category
    
     category_controller = params[:controller].classify.constantize
     @category_controller = category_controller.find(params[:id])
         if @category_controller.category == 'Admin'
            if User.admin.count < 2 #Her sørges der for, at der altid er mindst 1 admin blandt Users
              #redirect_to(:controller => 'users', :action => 'index')
              flash[:notice] = 'Kan ikke ændres. Altid mindst én admin tilgængelig'
            else
              @category_controller.category = 'Editor'
            end
         elsif @category_controller.category == 'Editor'
           @category_controller.category = 'User'
         elsif @category_controller.category == 'User'
           @category_controller.category = 'Public'
         elsif @category_controller.category == 'Public'
            @category_controller.category = 'Admin'
         end

     @category_controller.update_attributes(params[:category_controller])
   
     redirect_to(:action => 'index')
  end
	
  private
  
  def set_user_language  
    I18n.locale = 'da'  
  end
  
  # def mobile_device?
  #   if session[:mobile_param]
  #     session[:mobile_param] == "1"
  #   else
  #     request.user_agent =~ /Mobile|webOS/
  #   end
  # end
  # 	
  # helper_method :mobile_device?
  # 
  # def prepare_for_mobile
  #   session[:mobile_param] = params[:mobile] if params[:mobile]
  #   request.format = :mobile if mobile_device?    
  # end
	

end
