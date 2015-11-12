class EventInvitationsController < ApplicationController
  def index
    @sent_invitations = User.sent_invitations
    @received_invitations = User.received_invitations
  end

  def show
    @invitation = EventInvitation.find(params[:id])
  end

  def new
    @event = Event.find(params[:id])
    @invitation = EventInvitation.new(:event_id => params[:id])
  end

  def create
    # set the invitee by email. if invitee is not in database, render error
    if @invitee = User.where(email: params[:event_invitation][:invitee].downcase).first
      @invitation = EventInvitation.new(invitation_params)
      if @invitation.save
        flash[:success] = "Invitation sent to #{@invitee.email}!"
        redirect_to events_path
      else
        flash.now[:danger] = "Error sending invitation"
        render 'new_invitation_path'
      end
    else
      flash[:danger] = "Invitee email not found."
      @event = Event.find_by(params[:event_id])
      @invitation = EventInvitation.new(:event_id => params[:id])
      redirect_to new_invitation_path(@event.id)
    end

  end

  private

    def invitation_params
      params[:event_invitation][:invitee_id] = @invitee.id
      params[:event_invitation][:inviter_id] = current_user.id
      params.require(:event_invitation).permit(:message, :event_id, :invitee_id, :inviter_id)
    end
end
