class GrantsController < ApplicationController

  def index
    @grants = current_user.grants
  end

  def create
    grant = current_user.grants.new(grant_params)
    grant.associate_screen_name_with_tweeter
    prev_grants = current_user.grants.where(grantee_id: grant.grantee_id).to_a
    if prev_grants.present?
      last_end = prev_grants.collect(&:ends).compact.max
      if grant.starts && last_end && grant.starts < last_end
        new_starts = (prev_grants.collect(&:starts) << grant.starts).compact.min
        new_ends = (prev_grants.collect(&:ends) << grant.ends).compact.max
        grant = prev_grants.slice!(0)
        grant.starts = new_starts
        grant.ends = new_ends
        prev_grants.map { |a| logger.info "dd"; a.destroy }
      end
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

  def destroy
    grant = Grant.find(params[:id])
    grant.destroy
    redirect_to tweeter_grants_path(current_user)
  end

  private
    def grant_params
      params[:starts] ||= Time.now
      params[:starts] = params[:starts].in_time_zone(current_user.timezone)
      params.require(:grant).permit(:grantee_screen_name, :starts, :ends)
    end
end
