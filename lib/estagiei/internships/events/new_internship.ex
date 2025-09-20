defmodule Estagiei.Internships.Events.NewInternship do
  alias Estagiei.Internships.Entities.Internship
  alias Estagiei.Events
  @topic "new_intership"

  def subscribe do
    Phoenix.PubSub.subscribe(Estagiei.PubSub, @topic)
  end

  def broadcast(%Internship{} = internship) do
    Phoenix.PubSub.broadcast(Estagiei.PubSub, @topic, Events.new(:new_internship, internship))
  end
end
