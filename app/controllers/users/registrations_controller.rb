# frozen_string_literal: true

class Users::RegistrationsController < Devise::RegistrationsController

  before_action :configure_permitted_parameters

  # GET /users/sign_up
  def new
    # Override Devise default behaviour and create a contact as well
    build_resource({})
    resource.contacts.build
    respond_with self.resource
  end

  # GET /users/edit
  def edit
    # Override Devise default behaviour and create a contact as well
    build_resource({})
    resource.contacts.build
    respond_with self.resource
  end

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:email, :password, :password_confirmation, :first_name, :last_name, :phone_number, :contacts_attributes => [:first_name, :last_name, :phone_number]] )
  end

  # The path used after sign up.
  # def after_sign_up_path_for(resource)
  #   super(resource)
  # end

  # The path used after sign up for inactive accounts.
  # def after_inactive_sign_up_path_for(resource)
  #   super(resource)
  # end
end
