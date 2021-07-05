class Admin::BaseController < ApplicationController
  include SessionsHelper
  layout "layouts/admin/application"
end
