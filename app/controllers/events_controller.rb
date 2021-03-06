class EventsController < ApplicationController
  def index
    @events = Event.all
  end

  def show
    @event = Event.find(params[:id])
  end

  def new
    @event = Event.new
  end

  def create
    @event = current_user.hosted_events.build(event_params)
    if @event.save
      flash[:success] = "Event created!"
      redirect_to events_path
    else
      flash.now[:danger] = "Error creating event."
      render 'new'
    end
  end

  private

    def event_params
      params.require(:event).permit(:title, :location, :description, :datetime, :creator_id)
    end
end
