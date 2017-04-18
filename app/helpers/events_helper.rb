module EventsHelper
	def event_form_url
		@event.new_record? ? gym_events_path(@event.gym) : gym_event_path(@event.gym, @event)
	end

end
