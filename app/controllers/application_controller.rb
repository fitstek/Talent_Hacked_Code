class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  # protect_from_forgery with: :exception
  protect_from_forgery with: :null_session

   before_filter :configure_permitted_parameters, if: :devise_controller?
   before_filter :sign_out_all_users, if: Proc.new { current_client && current_developer }

   layout :layout_by_resource


  	protected

    def user_for_paper_trail
      admin_user_signed_in? ? current_admin_user : 'User'
    end

  	def configure_permitted_parameters
    	devise_parameter_sanitizer.for(:sign_in) { |u| u.permit(:email, :password, :remember_me) }
    	devise_parameter_sanitizer.for(:sign_up) { |u| u.permit(:name, :email, :password, :password_confirmation) }
    	devise_parameter_sanitizer.for(:account_update) { |u| u.permit(:name, :dob, :gender, :email, :phone, :address, :bio, :companyBio, :interests, :skills, :qualifications, :experience, :dayRate, :exInd, :languages, :website, :github, :twitter, :facebook, :linkedinPublicUrl, :avatarUrl, :password, :password_confirmation, :current_password, :industry, :role, :mobile, :contact, :image, :dayrate, :deadline, :projectIndustry, :status, :project_id, :developer_id) }
    	devise_parameter_sanitizer.for(:password_edit) { |u| u.permit(:name, :email, :password, :password_confirmation, :current_password) }
    	devise_parameter_sanitizer.for(:password_new) { |u| u.permit(:name, :email, :password, :password_confirmation, :current_password) }
  	end

    def sign_out_all_users
        sign_out(current_client)
        sign_out(current_developer)
    end

    def layout_by_resource
      if devise_controller? && (resource_name == :developer || resource_name == :client) && action_name == 'new'
        false
      else
        'application'  
      end
    end
end
