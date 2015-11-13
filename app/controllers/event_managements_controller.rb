class EventManagementsController < ApplicationController
  def new
    @event = Event.find(params[:id])
    @event_management = EventManagement.new(:event_id => params[:id])
  end

  def create
    # set the admin by email. if admin is not in database, render error
    if @admin = User.where(email: params[:event_management][:admin].downcase).first
      @event_management = EventManagement.new(event_management_params)
      if @event_management.save
        flash[:success] = "#{@admin.full_name} appointed to admin!"
        redirect_to event_path(params[:event_management][:event_id])
      else
        flash[:danger] = "Error appointing admin."
        event_id = params[:event_management][:event_id]
        redirect_to new_admin_path(event_id)
      end
    else
      flash[:danger] = "Invitee email not found."
      event_id = params[:event_management][:event_id]
      redirect_to new_admin_path(event_id)
    end

  end

  def destroy
  end

  private

    def event_management_params
      params[:event_management][:admin_id] = @admin.id
      params.require(:event_management).permit(:event_id, :admin_id)
    end
end
