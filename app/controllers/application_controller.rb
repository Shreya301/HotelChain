class ApplicationController < ActionController::Base
  before_action :accept_all_params
  before_action :set_branches
  private
  def accept_all_params
    params.permit!
  end
  def set_branches
    # SELECT branch_name, id FROM hotels;
    @branches = Hotel.all.pluck(:branch_name, :id)
    @branches_hash = @branches.to_h.invert
  end
end
