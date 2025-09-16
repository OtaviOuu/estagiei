defmodule EstagieiWeb.EstagioLive.Show do
  use EstagieiWeb, :live_view

  alias Estagiei.Internships

  def mount(%{"id" => id}, _session, socket) do
    {:ok, assign(socket, :internship, Internships.get_internship!(id))}
  end

  def render(assigns) do
    ~H"""
    <Layouts.app flash={@flash}>
      <h1>
        {@internship.title}
      </h1>

      <p>
        {@internship.description |> raw()}
      </p>
    </Layouts.app>
    """
  end
end
