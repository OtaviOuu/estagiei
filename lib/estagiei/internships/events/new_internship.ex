defmodule Estagiei.Internships.Events.NewInternship do
  @topic "new_intership"
  @pubsub Estagiei.PubSub
  def subscribe do
    Phoenix.PubSub.subscribe(@pubsub, @topic)
  end

  def broadcast({:error, _reason} = error), do: error

  def broadcast({:ok, internship} = result) do
    Phoenix.PubSub.broadcast(@pubsub, @topic, {:new_internship, internship})
    result
  end
end
