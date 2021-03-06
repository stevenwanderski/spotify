class AuthenticatedController < ApplicationController
  layout 'authenticated'
  before_action :authenticate_user!
  before_action :assign_tags
  before_action :assign_access_token

  private

  def assign_tags
    @tags = current_user.tags.order(name: :asc)
  end

  def assign_access_token
    current_user.ensure_token!
    @access_token = current_user.auth_hash['credentials']['token']
  end
end
