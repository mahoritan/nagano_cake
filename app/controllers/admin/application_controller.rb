class Admin::ApplicationController < ActionController::Base

before_action :authenticate_admin!


end
