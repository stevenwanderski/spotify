class AuthenticatedController < ApplicationController
  layout 'authenticated'
  before_action :authenticate_user!
  before_action :assign_tags

  private

  def assign_tags
    @tags = current_user.tags
  end
end
