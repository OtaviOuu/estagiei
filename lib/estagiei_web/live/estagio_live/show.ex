defmodule EstagieiWeb.EstagioLive.Show do
  use EstagieiWeb, :live_view
  alias Estagiei.Internships

  def mount(%{"slug" => job_slug}, _session, socket) do
    internship = Internships.get_internship_by_slug!(job_slug)
    {:ok, assign(socket, :internship, internship)}
  end

  def render(assigns) do
    ~H"""
    <Layouts.app flash={@flash}>
      <h1>{@internship.title}</h1>
      <div>
        {@internship.description |> raw()}
      </div>
    </Layouts.app>
    """
  end
end
