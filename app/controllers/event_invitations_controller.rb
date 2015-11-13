class EventInvitationsController < ApplicationController
  def index
    if current_user.nil?
      @sent_invitations = []
      @received_invitations = []
    else
      @sent_invitations = current_user.sent_invitations
      @received_invitations = current_user.received_invitations
    end
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
        flash[:danger] = "Error sending invitation. The user may have already been invited or you are not the host."
        event_id = params[:event_invitation][:event_id]
        redirect_to new_invitation_path(event_id)
      end
    else
      flash[:danger] = "Invitee email not found."
      event_id = params[:event_invitation][:event_id]
      redirect_to new_invitation_path(event_id)
    end
  end

  def accept
    @invite = EventInvitation.find(params[:id])
    @invite.update_attributes(attending: true)
    redirect_to invites_path
  end

  def decline
    @invite = EventInvitation.find(params[:id])
    @invite.update_attributes(attending: false)
    redirect_to invites_path
  end

  private

    def invitation_params
      params[:event_invitation][:invitee_id] = @invitee.id
      params[:event_invitation][:inviter_id] = current_user.id
      params.require(:event_invitation).permit(:message, :event_id, :invitee_id, :inviter_id)
    end
end
