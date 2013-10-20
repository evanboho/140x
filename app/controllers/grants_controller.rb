class GrantsController < ApplicationController

  def index
    @grants = current_user.grants
  end

  def create
    grant = current_user.grants.new(grant_params)
    grant.associate_screen_name_with_tweeter
    prev_grants = current_user.grants.where(grantee_id: grant.grantee_id).to_a
    if prev_grants.present?
      Rails.logger.info "a"
      new_starts = (prev_grants.collect(&:starts) << grant.starts).compact.min
      new_ends = (prev_grants.collect(&:ends) << grant.ends).compact.max
      Rails.logger.info "b"
      grant = prev_grants.slice!(0)
      grant.starts = new_starts
      Rails.logger.info "c"
      grant.ends = new_ends
      Rails.logger.info "d"
      prev_grants.map { |a| logger.info "dd"; a.destroy }
      Rails.logger.info "e"
    end
    if grant.save
      redirect_to tweeter_grants_path(current_user), notice: "Access Granted!"
    else
     redirect_to tweeter_grants_path(current_user), notice: "We couldn't create new access."
    end
  end

  def update
    grant = current_user.grants.find(params[:id])
    if grant.update_attributes(grant_params)
      redirect_to tweeter_grants_path(current_user), notice: "Access Granted!"
    else
      redirect_to tweeter_grants_path(current_user), notice: "We couldn't grant that tweeter access."
    end
  end

  private
    def grant_params
      params.require(:grant).permit(:grantee_screen_name, :starts, :ends)
    end
end
